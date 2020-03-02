#!/bin/bash
#
# Script : compile.sh
# Use    : This script builds the sphinx documentation.
#
# ######################################################################################################################


# ----------------------------------------------------------------------------------------------------------------------
# Variables
#
export DATE_TIME=$(date "+%s")


# ----------------------------------------------------------------------------------------------------------------------
# TEARDOWN
#
teardown(){
	ret=$?

	local msg=(
	"[INFO] - script success :"
	"[INFO] - script aborted : "
	"[ERROR] - script failed : "
	)

  time=$(date "+%s")
	echo -e "[INFO] - Script duration : $((time - DATE_TIME)) s"
	if [ $ret -eq "0" ]; then
      [ -z "$VAR" ] && echo "${msg[0]} $0 ($ret)." || echo "${msg[1]} $0 ($ret)."
	else
		echo "${msg[2]} $0 ($ret)."
	fi
}
trap teardown EXIT;


# ######################################################################################################################
# FUNCTIONS
#
function build_hmtl_doc(){

  local pygment_file="build/html/_static/pygments.css"
  local build_folder="build/html/_static/css"
  local source_folder="source/_static/"

  local html_index_path="build/html/index.html"

  # ------------------------------------------------------------------------------
  # PRE BUILD - Move custom css
  #
  echo -e "PREBUILD\n--------\n"
  [ -e "${build_folder}/doge.css" ] && rm -vf "${build_folder}/doge.css" || :
  cp -v "${source_folder}/doge.css" "${build_folder}"

  # ------------------------------------------------------------------------------
  # BUILD
  #
  echo -e "\n\nBUILD - HTML\n-------------\n"
  make html

  # ------------------------------------------------------------------------------
  # POST BUILD - Ajust css
  #
  echo -e "\n\nPOSTBUILD\n---------\n"
  sed -i 's|.highlight  { background: #eeffcc; }|.highlight  { background: #eff9ff; }|g' $pygment_file
  echo -e "$(basename $pygment_file) - Updated with custom highlights"

  echo -e "\n\n[INFO] - Documentation at $(pwd)/${hmtl_index_path}"
}

function build_latex_doc(){

  echo -e "This function might make the build fail."
  while true; do
    read -p "Make PDF Doc - Execute it ? " x
    case $x in
      [Yy]es ) make pdf ;;
      [Nn]o  ) VAR=1; exit 0;;
      *      ) echo "Please answer yes or no.";;
    esac
  done

}

function show_help(){
cat <<-EOF
opencv_install.sh

Usage : ./opencv_install.sh <action> <args>

Parameters
   Action                 Arguments                       Descr.
   ----------------------+-------------------------------+--------------------------------------------------------------
   --html         | -w    None                            Build html doc.
   --pdf          | -p    None                            Build latex based PDF doc.
   --both         | -b    None                            Build html and PDF doc.
   --help         | -h    None                            Show this help and exit.


Examples :
            ./compile.sh --html

EOF
}

# ######################################################################################################################
# MAIN
#
case $1 in
	--html  | -w ) VALUE="html";;
  --pdf   | -p ) VALUE="pdf";;
  --both  | -b ) VALUE="both";;
	--help  | -h ) VALUE="help";;
    *) if ! [[ -z $1 ]]; then echo -e "Incorrect command: $1"; show_help; exit; else shift 1; fi;;
esac


if [ $VALUE == "html" ]; then
  build_hmtl_doc
elif [ $VALUE == "pdf" ]; then
  build_latex_doc
elif [ $VALUE == "both" ]; then
  build_hmtl_doc
  build_latex_doc
elif [ $VALUE == "help" ]; then
  VAR=1; show_help;
else
    echo -e "[ERROR] - an error occured : ${VALUE} ; ret $?"
fi

