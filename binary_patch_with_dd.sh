#!/bin/bash
#developer, please populate below variables 
#use $(digest -v -a md5 $file_to_patch) to calculate md5 sums
md5_checksum_original=""
md5_checksum_patched=""
hex_sequence_to_be_patched="\x90\x90\x90\x90"
file_to_patch="test_elf_binary"
target_directory="/opt/"

if [ -f "$file_to_patch" ]; then
	#test md5 sum
	current_md5=$(digest -v -a md5 $file_to_patch | awk '{print $4}')
	if [[ "$md5_checksum_original" == "$current_md5" ]]; then	
		cp $file_to_patch $file_to_patch".org"
		printf $hex_sequence_to_be_patched | dd of=$file_to_patch bs=1 seek=167051 conv=notrunc &> /dev/null
		new_md5=$(digest -v -a md5 $file_to_patch | awk '{print $4}')
		if [[ "$md5_checksum_patched" == "$new_md5" ]]; then
			echo $file_to_patch" successfully patched!"
		else
			echo "patching "$file_to_patch" failed!"
		fi
	else
		if [[ "$current_md5" == "$md5_checksum_patched" ]]; then
			echo $file_to_patch" already patched => wont continue patching."
		else
			echo $file_to_patch" has an unknown md5sum => wont continue patching."
		fi
	fi
else
	echo $file_to_patch" not found in current dir. Please move this script to "$target_directory" and run it again" 
fi

