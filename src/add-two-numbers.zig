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
        if (l1) |l1_node| if (l2) |l2_node| {
            var sum_val = l1_node.val + l2_node.val;

            const head = try ListNode.init(allocator, sum_val);
            var current = head;

            while (l1_node.next) |node| {
                if (l2_node.next) |node2| {
                    sum_val = node.val + node2.val;
                    const new_node = try ListNode.init(allocator, sum_val);
                    current.next = new_node;
                    current = new_node;
                    l2_node = node2.next;
                }
            }
            return head;
        } else {
            return null;
        } else {
            return null;
        }

        return null;
    }
};

// Helper function to create linked list from array
fn createList(allocator: std.mem.Allocator, values: []const i32) !?*ListNode {
    if (values.len == 0) return null;
    const head = try ListNode.init(allocator, values[0]);
    var current = head;
    for (values, 1..) |val, index| {
        _ = index;
        const new_node = try ListNode.init(allocator, val);
        current.node = new_node;
        current = new_node;
    }

    return head;
}

// Helper function to convert linked list to array for comparison
fn listToArray(allocator: std.mem.Allocator, head: ?*ListNode) ![]i32 {
    if (head) |head_node| {
        var list = std.ArrayListUnmanaged(i32){};
        var current = head_node;
        while (current) |node| {
            try list.append(allocator, node.val);
            current = current.node;
        }
        const arr: []const i32 = list.items;

        return &arr;
    } else {
        return &[_]i32{};
    }
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

    // TODO: Create linked lists from arrays
    // TODO: Call addTwoNumbers
    // TODO: Convert result to array and compare with expected
    // TODO: Free all allocated memory

    _ = l1_values;
    _ = l2_values;
    _ = expected;
    _ = allocator;
}

test "example 2: l1 = [0], l2 = [0], output = [0]" {
    const allocator = std.testing.allocator;

    // Input: l1 = [0], l2 = [0]
    // Output: [0]
    const l1_values = [_]i32{0};
    const l2_values = [_]i32{0};
    const expected = [_]i32{0};

    // TODO: Create linked lists from arrays
    // TODO: Call addTwoNumbers
    // TODO: Convert result to array and compare with expected
    // TODO: Free all allocated memory

    _ = l1_values;
    _ = l2_values;
    _ = expected;
    _ = allocator;
}

test "example 3: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9], output = [8,9,9,9,0,0,0,1]" {
    const allocator = std.testing.allocator;

    // Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
    // Output: [8,9,9,9,0,0,0,1]
    const l1_values = [_]i32{ 9, 9, 9, 9, 9, 9, 9 };
    const l2_values = [_]i32{ 9, 9, 9, 9 };
    const expected = [_]i32{ 8, 9, 9, 9, 0, 0, 0, 1 };

    // TODO: Create linked lists from arrays
    // TODO: Call addTwoNumbers
    // TODO: Convert result to array and compare with expected
    // TODO: Free all allocated memory

    _ = l1_values;
    _ = l2_values;
    _ = expected;
    _ = allocator;
}
