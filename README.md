# patch_elf_binary
Small bash script that allows to patch a Linux elf binary with a custom sequence of bytes

Before usage update according variables:
```
md5_checksum_original=""
md5_checksum_patched=""
hex_sequence_to_be_patched="\x90\x90\x90\x90"
file_to_patch="test_elf_binary"
target_directory="/opt/"
```
use digest to calculate md5 sums:
```
new_md5=$(digest -v -a md5 $file_to_patch | awk '{print $4}')
```
