# Add Two Numbers - Solution

## Problem Description

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

## Intuition

The problem mimics the way we add numbers by hand - starting from the least significant digit (rightmost) and carrying over when the sum exceeds 9. Since the linked lists are already in reverse order (least significant digit first), we can traverse both lists simultaneously, adding corresponding digits along with any carry from the previous position.

## Approach

1. **Use a dummy head**: Create a dummy node to simplify the logic of building the result list. This avoids special handling for the first node.

2. **Iterate through both lists**: Traverse both linked lists simultaneously using two pointers (`p1` and `p2`).

3. **Handle different lengths**: Continue iteration while either list has remaining nodes or there's a carry to process.

4. **Calculate sum and carry**: For each position:
   - Add the values from both nodes (if they exist) plus any carry from the previous position
   - Calculate the new carry: `carry = sum / 10`
   - Calculate the digit to store: `digit = sum % 10`

5. **Build result list**: Create a new node with the calculated digit and link it to the result list.

6. **Return result**: Return `dummy.next` as the head of the result list.

## Complexity Analysis

- **Time Complexity**: O(max(m, n)) where m and n are the lengths of the two linked lists. We traverse both lists once.

- **Space Complexity**: O(max(m, n)) for the new linked list. The length of the result list is at most max(m, n) + 1 (when there's a final carry).

## Code (Zig)

```zig
const ListNode = struct {
    val: i32,
    next: ?*ListNode,
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
```

## Key Points

1. **Dummy Node Pattern**: Using a dummy head simplifies the code by eliminating the need to handle the first node as a special case.

2. **Null Handling**: Zig's optional types (`?*ListNode`) provide compile-time null safety. We use `if (p1) |node|` syntax to safely unwrap optional pointers.

3. **Carry Propagation**: The loop condition `while (p1 != null or p2 != null or carry != 0)` ensures we process all digits and any final carry.

4. **Edge Cases Handled**:
   - Lists of different lengths
   - Final carry (e.g., 999 + 1 = 1000)
   - Single digit numbers
   - Zero values

## Example Walkthrough

**Input**: l1 = [2,4,3], l2 = [5,6,4]
**Output**: [7,0,8]
**Explanation**: 342 + 465 = 807

| Step | p1 | p2 | carry | sum | digit | Result |
|------|----|----|-------|-----|-------|--------|
| 1 | 2 | 5 | 0 | 7 | 7 | [7] |
| 2 | 4 | 6 | 0 | 10 | 0 | [7,0] |
| 3 | 3 | 4 | 1 | 8 | 8 | [7,0,8] |

## Alternative Solutions

1. **Recursive Approach**: Could solve recursively by adding current digits and recursively calling on the next nodes with the carry.

2. **In-place Modification**: Could modify one of the input lists instead of creating a new one (though this violates immutability principles).

3. **Convert to Numbers**: For small inputs, could convert linked lists to integers, add them, and convert back (but this doesn't work for very large numbers).

The iterative approach presented is optimal for this problem as it's straightforward, efficient, and handles arbitrarily large numbers.
