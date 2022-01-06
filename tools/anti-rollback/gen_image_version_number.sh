#Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.

#Permission to use, copy, modify, and/or distribute this software for any
#purpose with or without fee is hereby granted, provided that the above
#copyright notice and this permission notice appear in all copies.

#THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
#!/bin/bash
out_file="$(pwd)/anti-rollback-version.txt"
version=`cat "$(pwd)/version.txt" | grep 'ar_version' | awk -F '=' '{print $2}'`

# Append a 32-bit word to the output file.
print_32bit()
{
	word32=$(printf "%08x\n" $1)

	byte0=$(echo $word32 | cut -b 1-2)
	byte1=$(echo $word32 | cut -b 3-4)
	byte2=$(echo $word32 | cut -b 5-6)
	byte3=$(echo $word32 | cut -b 7-8)

	printf "\x$byte0" >> $out_file
	printf "\x$byte1" >> $out_file
	printf "\x$byte2" >> $out_file
	printf "\x$byte3" >> $out_file
}

if [ -e $out_file ]; then
	rm -f $out_file
fi

print_32bit 0x1ef1e916
print_32bit $version
