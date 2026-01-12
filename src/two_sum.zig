const std = @import("std");

/// Two Sum - Find two numbers that add up to target
/// Returns indices of the two numbers such that they add up to target
pub fn twoSum(allocator: std.mem.Allocator, nums: []const i32, target: i32) !?[2]usize {
    var set = std.AutoArrayHashMap(i32, usize).init(allocator);
    defer set.deinit();
    for (nums, 0..) |num, index| {
        const diff = target - num;
        if (set.get(diff)) |j| {
            return [2]usize{ j, index };
        }
        try set.put(num, index);
    }

    return null;
}

test "two sum - example 1" {
    // Input: nums = [2,7,11,15], target = 9
    // Output: [0,1]
    // Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 2, 7, 11, 15 };
    const target: i32 = 9;

    const result = try twoSum(allocator, &nums, target);

    try std.testing.expect(result != null);
    try std.testing.expectEqual(@as(usize, 0), result.?[0]);
    try std.testing.expectEqual(@as(usize, 1), result.?[1]);
}

test "two sum - example 2" {
    // Input: nums = [3,2,4], target = 6
    // Output: [1,2]
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 3, 2, 4 };
    const target: i32 = 6;

    const result = try twoSum(allocator, &nums, target);

    try std.testing.expect(result != null);
    try std.testing.expectEqual(@as(usize, 1), result.?[0]);
    try std.testing.expectEqual(@as(usize, 2), result.?[1]);
}

test "two sum - example 3" {
    // Input: nums = [3,3], target = 6
    // Output: [0,1]
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 3, 3 };
    const target: i32 = 6;

    const result = try twoSum(allocator, &nums, target);

    try std.testing.expect(result != null);
    try std.testing.expectEqual(@as(usize, 0), result.?[0]);
    try std.testing.expectEqual(@as(usize, 1), result.?[1]);
}

test "two sum - no solution" {
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 1, 2, 3 };
    const target: i32 = 10;

    const result = try twoSum(allocator, &nums, target);

    try std.testing.expect(result == null);
}
