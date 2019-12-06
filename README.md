# HTTP_Parser
This repo frames the HTTP message parser as a CMSIS-Pack  (upstream: https://github.com/nodejs/http-parser)

## Prerequisites
Working with this repository requires the following applications and packs to be installed on your PC:
- bash compatible shell (under Windows, use for example [git bash](https://gitforwindows.org/))
- ZIP archive creation utility (e.g. [7-Zip](https://www.7-zip.org/))
- The `gen_pack.sh` script assumes that the ARM.CMSIS.5.6.0.pack is installed on your PC. It also makes assumptions regarding the installation path. If execution fails, adapt the pack installation path accordingly.

## Instructions
1. Open a bash compatible shell
2. Clone the repository: `git clone https://github.com/MDK-Packs/HTTP_Parser.git`
3. Run `./get_upstream.sh`
4. Run `./add_merge.sh` to copy files from `contributions/add` to a `./local` directory
5. You can now add the `./local/Arm-Packs.HTTP_Parser.pdsc` to the list of local repositories in Pack Installer. This enables direct access to its content without the need to re-build and re-install the pack after modifications.

### Creating a CMSIS-Pack
1. Run `./gen_pack.sh`
2. Install the pack created in the `./pack` directory (e.g. double-click on the pack file)

### Making changes to the CMSIS-Pack
Contributions are welcome. Please raise a pull-request via GitHub: https://github.com/MDK-Packs/HTTP_Parser. All contributions shall be placed in either:  
- `./contributions/add` (additional content)
- `./contributions/merge` (changed content)

To update your local pack content run `./add_merge.sh.`

### Contributing to the upstream repository
Alternatively, you can contribute using pull-requests to the upstream repository https://github.com/nodejs/http-parser.
1. Run `./get_upstream.sh vX.Y.Z` to download an updated upstream revision
2. Add a new release tag and release description to the PDSC file (`contributions/add/MDK-Packs.HTTP_Parser.pdsc`)

*Note:* please review all files in the `./contributions/merge` folder, as they may require updating to reflect changes of the upstream repository.
