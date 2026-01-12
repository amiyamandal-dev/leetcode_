const std = @import("std");

pub fn max_sub_array(nums: []const i32) i32 {
    if (nums.len == 1) return nums[0];
    var max_sum: i32 = nums[0];
    var current_sum: i32 = 0;
    for (nums, 1..) |num, i| {
        _ = i;
        if (current_sum < 0) {
            current_sum = 0;
        }
        current_sum += num;
        max_sum = @max(current_sum, max_sum);
    }

    return max_sum;
}

test "testcase 1" {
    const input_val = [_]i32{ -2, 1, -3, 4, -1, 2, 1, -5, 4 };
    const result = 6;
    const pred = max_sub_array(&input_val);

    try std.testing.expectEqual(result, pred);
}

test "testcase 2" {
    const input_val = [_]i32{1};
    const result = 1;
    const pred = max_sub_array(&input_val);

    try std.testing.expectEqual(result, pred);
}

test "testcase 3" {
    const input_val = [_]i32{ 5, 4, -1, 7, 8 };
    const result = 23;
    const pred = max_sub_array(&input_val);

    try std.testing.expectEqual(result, pred);
}
