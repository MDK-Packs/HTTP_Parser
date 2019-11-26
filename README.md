# HTTP_Parser
This repo frames the HTTP message parser as a CMSIS-PACK  (upstream: https://github.com/nodejs/http-parser)

# Instructions
1) open a bash compatible shell
2) clone repository: git clone git@github.com:MDK-Packs/HTTP_Parser.git
3) run ./get_upstream.sh
4) run ./add_merge.sh to copy files from contributions/add to 'local' directory 

a) Creating the CMSIS pack:
   1) run ./gen_pack.sh
   2) install the pack created in ./pack directory (e.g. double click on the pack file).
   3) the component 'IoT Utility:http-parser' is now available in the RTE dialog of your CMSIS-Pack aware tools.

b) Making changes to the CMSIS pack:  
   You can develop and extend this pack further by contributing via GitHub 
   https://github.com/MDK-Packs/HTTP_Parser  
   All contributions shall be placed in either:  
   i)  contributions/add (additional content)  
   ii) contributions/merge (changed content)  
   To update your local pack content run ./add_merge.sh  
   You can add the .../local/MDK-Packs.HTTP_Parser.pdsc to the list of local repositories in the PackInstaller.
   This way you avoid to create and install a new pack after modifications.

c) Alternatively you can contribute using pull-requests to the upstream repository 
   https://github.com/nodejs/http-parser  
   run ./get_upstream.sh vX.Y.Z to download an updated upstream revision  
   add a new release tag and release description to the PDSC file (contributions/add/MDK-Packs.HTTP_Parser.pdsc)  
   Note: please review all files in the 'merge' folder, as they may require updating to reflect changes of the upstream
   repository.

