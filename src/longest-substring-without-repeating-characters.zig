const std = @import("std");

/// Longest Substring Without Repeating Characters
/// Returns the length of the longest substring without repeating characters
pub fn lengthOfLongestSubstring(s: []const u8) !usize {
    if (s.len == 0) return 0;

    const allocator = std.heap.page_allocator;
    var map = std.AutoHashMap(u8, usize).init(allocator);
    defer map.deinit();

    var max_len: usize = 0;
    var left: usize = 0;

    for (s, 0..) |char, right| {
        // If character exists and its position is within current window
        if (map.get(char)) |prev_index| {
            if (prev_index >= left) {
                left = prev_index + 1;
            }
        }

        try map.put(char, right);
        max_len = @max(max_len, right - left + 1);
    }

    return max_len;
}

test "longest substring - example 1" {
    // Input: s = "abcabcbb"
    // Output: 3
    // Explanation: The answer is "abc", with the length of 3.
    const s = "abcabcbb";

    const result = lengthOfLongestSubstring(s);

    try std.testing.expectEqual(@as(usize, 3), result);
}

test "longest substring - example 2" {
    // Input: s = "bbbbb"
    // Output: 1
    // Explanation: The answer is "b", with the length of 1.
    const s = "bbbbb";

    const result = lengthOfLongestSubstring(s);

    try std.testing.expectEqual(@as(usize, 1), result);
}

test "longest substring - example 3" {
    // Input: s = "pwwkew"
    // Output: 3
    // Explanation: The answer is "wke", with the length of 3.
    const s = "pwwkew";

    const result = lengthOfLongestSubstring(s);

    try std.testing.expectEqual(@as(usize, 3), result);
}

test "longest substring - empty string" {
    const s = "";

    const result = lengthOfLongestSubstring(s);

    try std.testing.expectEqual(@as(usize, 0), result);
}
