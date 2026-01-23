const std = @import("std");

const Solution = struct {
    pub fn maxProfit(prices: []const i32) i32 {
        // TODO: Implement logic
        // Track minimum price seen so far and maximum profit
        _ = prices;
        return 0;
    }
};

test "testcase 1 - profit possible" {
    const prices = [_]i32{ 7, 1, 5, 3, 6, 4 };
    const expected: i32 = 5;
    const result = Solution.maxProfit(&prices);

    try std.testing.expectEqual(expected, result);
}

test "testcase 2 - no profit possible" {
    const prices = [_]i32{ 7, 6, 4, 3, 1 };
    const expected: i32 = 0;
    const result = Solution.maxProfit(&prices);

    try std.testing.expectEqual(expected, result);
}

test "testcase 3 - single element" {
    const prices = [_]i32{1};
    const expected: i32 = 0;
    const result = Solution.maxProfit(&prices);

    try std.testing.expectEqual(expected, result);
}

test "testcase 4 - two elements with profit" {
    const prices = [_]i32{ 1, 2 };
    const expected: i32 = 1;
    const result = Solution.maxProfit(&prices);

    try std.testing.expectEqual(expected, result);
}
