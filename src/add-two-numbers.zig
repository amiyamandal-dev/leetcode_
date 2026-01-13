const std = @import("std");

// Definition for singly-linked list
const ListNode = struct {
    val: i32,
    next: ?*ListNode,

    pub fn init(allocator: std.mem.Allocator, val: i32) !*ListNode {
        const node = try allocator.create(ListNode);
        node.* = ListNode{
            .val = val,
            .next = null,
        };
        return node;
    }

    pub fn deinit(self: *ListNode, allocator: std.mem.Allocator) void {
        var current = self;
        while (current.next) |next| {
            allocator.destroy(current);
            current = next;
        }
        allocator.destroy(current); // Destroy the last node
    }
};

const Solution = struct {
    pub fn addTwoNumbers(l1: ?*ListNode, l2: ?*ListNode, allocator: std.mem.Allocator) !?*ListNode {
        var dummy = ListNode{ .val = 0, .next = null };
        var current: *ListNode = &dummy;
        var carry: i32 = 0;
        var p1 = l1;
        var p2 = l2;

        while (p1 != null or p2 != null or carry != 0) {
            var sum = carry;
            if (p1) |node| {
                sum += node.val;
                p1 = node.next;
            }
            if (p2) |node| {
                sum += node.val;
                p2 = node.next;
            }
            carry = @divFloor(sum, 10);
            const digit = @rem(sum, 10);
            const new_node = try ListNode.init(allocator, digit);
            current.next = new_node;
            current = new_node;
        }

        return dummy.next;
    }
};

// Helper function to create linked list from array
fn createList(allocator: std.mem.Allocator, values: []const i32) !?*ListNode {
    if (values.len == 0) return null;
    const head = try ListNode.init(allocator, values[0]);
    var current = head;
    for (values[1..]) |val| {
        const new_node = try ListNode.init(allocator, val);
        current.next = new_node;
        current = new_node;
    }

    return head;
}

// Helper function to convert linked list to array for comparison
fn listToArray(allocator: std.mem.Allocator, head: ?*ListNode) ![]i32 {
    var list = std.ArrayListUnmanaged(i32){};
    defer list.deinit(allocator);
    var current = head;
    while (current) |n| {
        try list.append(allocator, n.val);
        current = n.next;
    }
    return try list.toOwnedSlice(allocator);
}

// Helper function to free linked list
fn freeList(allocator: std.mem.Allocator, head: ?*ListNode) void {
    if (head) |node| {
        node.deinit(allocator);
    }
}

test "example 1: l1 = [2,4,3], l2 = [5,6,4], output = [7,0,8]" {
    const allocator = std.testing.allocator;

    // Input: l1 = [2,4,3], l2 = [5,6,4]
    // Output: [7,0,8]
    // Explanation: 342 + 465 = 807
    const l1_values = [_]i32{ 2, 4, 3 };
    const l2_values = [_]i32{ 5, 6, 4 };
    const expected = [_]i32{ 7, 0, 8 };

    const l1 = try createList(allocator, &l1_values);
    defer freeList(allocator, l1);
    const l2 = try createList(allocator, &l2_values);
    defer freeList(allocator, l2);

    const result = try Solution.addTwoNumbers(l1, l2, allocator);
    defer freeList(allocator, result);

    const result_arr = try listToArray(allocator, result);
    defer allocator.free(result_arr);

    try std.testing.expectEqualSlices(i32, &expected, result_arr);
}

test "example 2: l1 = [0], l2 = [0], output = [0]" {
    const allocator = std.testing.allocator;

    // Input: l1 = [0], l2 = [0]
    // Output: [0]
    const l1_values = [_]i32{0};
    const l2_values = [_]i32{0};
    const expected = [_]i32{0};

    const l1 = try createList(allocator, &l1_values);
    defer freeList(allocator, l1);
    const l2 = try createList(allocator, &l2_values);
    defer freeList(allocator, l2);

    const result = try Solution.addTwoNumbers(l1, l2, allocator);
    defer freeList(allocator, result);

    const result_arr = try listToArray(allocator, result);
    defer allocator.free(result_arr);

    try std.testing.expectEqualSlices(i32, &expected, result_arr);
}

test "example 3: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9], output = [8,9,9,9,0,0,0,1]" {
    const allocator = std.testing.allocator;

    // Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
    // Output: [8,9,9,9,0,0,0,1]
    const l1_values = [_]i32{ 9, 9, 9, 9, 9, 9, 9 };
    const l2_values = [_]i32{ 9, 9, 9, 9 };
    const expected = [_]i32{ 8, 9, 9, 9, 0, 0, 0, 1 };

    const l1 = try createList(allocator, &l1_values);
    defer freeList(allocator, l1);
    const l2 = try createList(allocator, &l2_values);
    defer freeList(allocator, l2);

    const result = try Solution.addTwoNumbers(l1, l2, allocator);
    defer freeList(allocator, result);

    const result_arr = try listToArray(allocator, result);
    defer allocator.free(result_arr);

    try std.testing.expectEqualSlices(i32, &expected, result_arr);
}
