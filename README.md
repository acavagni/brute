# brute

## display all the combinantions from the characters lists passed as agruments

```
This script is used to generate all possible combinations of the character lists passed as arguments.
list<X> must be a list of characters separated by comma (or a range specified by - sign) of the <X> output column.

Usage: brute.pl [options] list1 [list2 ...]

Options must be one of the following:
    --index                    display line number
    --sep    <separator>       use <separator> to catenate lists
    --rev                      reverse each line before print
    --help                     this help

Examples:
    brute.pl --sep ' - ' --rev 0,1 0,1 0,1
    brute.pl --index 0x 0-9,A-F 0-9,A-F
```

## Example

```
$ ./brute.pl --index 1-3 - xx 5-6 A-B 000 c-d 
  1: 1-xx5A000c
  2: 2-xx5A000c
  3: 3-xx5A000c
  4: 1-xx6A000c
  5: 2-xx6A000c
  6: 3-xx6A000c
  7: 1-xx5B000c
  8: 2-xx5B000c
  9: 3-xx5B000c
 10: 1-xx6B000c
 11: 2-xx6B000c
 12: 3-xx6B000c
 13: 1-xx5A000d
 14: 2-xx5A000d
 15: 3-xx5A000d
 16: 1-xx6A000d
 17: 2-xx6A000d
 18: 3-xx6A000d
 19: 1-xx5B000d
 20: 2-xx5B000d
 21: 3-xx5B000d
 22: 1-xx6B000d
 23: 2-xx6B000d
 24: 3-xx6B000d
```
