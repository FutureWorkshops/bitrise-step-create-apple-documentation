#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -e

#=======================================
# Functions
#=======================================

RESTORE='\033[0m'
RED='\033[00;31m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
GREEN='\033[00;32m'

function color_echo {
	color=$1
	msg=$2
	echo -e "${color}${msg}${RESTORE}"
}

function echo_fail {
	msg=$1
	echo
	color_echo "${RED}" "${msg}"
	exit 1
}

function echo_warn {
	msg=$1
	color_echo "${YELLOW}" "${msg}"
}

function echo_info {
	msg=$1
	echo
	color_echo "${BLUE}" "${msg}"
}

function echo_details {
	msg=$1
	echo "  ${msg}"
}

function echo_done {
	msg=$1
	color_echo "${GREEN}" "  ${msg}"
}

function validate_required_input {
	key=$1
	value=$2
	if [ -z "${value}" ] ; then
		echo_fail "[!] Missing required input: ${key}"
	fi
}

function validate_required_input_with_options {
	key=$1
	value=$2
	options=$3

	validate_required_input "${key}" "${value}"

	found="0"
	for option in "${options[@]}" ; do
		if [ "${option}" == "${value}" ] ; then
			found="1"
		fi
	done

	if [ "${found}" == "0" ] ; then
		echo_fail "Invalid input: (${key}) value: (${value}), valid options: ($( IFS=$", "; echo "${options[*]}" ))"
	fi
}

function create_jazzy_config() {
	CONFIGPATH=$1
	SCHEMENAME=$2
	LANGUAGE=$3
	AUTHOR=$4

	if [ -f "$CONFIGPATH" ]; then
		rm "$CONFIGPATH"
	fi

	echo "" > "$CONFIGPATH"

	echo "author: $AUTHOR" >> "$CONFIGPATH"

	if [[ "$language" == "objc" ]]; then
		return 0
	fi

	echo "xcodebuild_arguments:" >> "$CONFIGPATH"
	echo "    - \"-scheme\"" >> "$CONFIG_PATH"
	echo "    - \"$SCHEMENAME\"" >> "$CONFIG_PATH"
}

#=======================================
# Main
#=======================================

#
# Informing values
echo_info "Configs:"

echo_details "* jazzy_configuration: $jazzy_configuration"
echo_details "* project_path: $project_path"
echo_details "* language: $language"
echo_details "* author: $author"
echo_details "* sdk: $sdk"
echo_details "* version: $version"
echo_details "* framework_root: $framework_root"
echo_details "* module: $module"
echo_details "* scheme: $scheme"
echo_details "* acl: $acl"
echo_details "* output: $output"
echo_details "* readme: $readme"
echo_details "* title: $title"
echo_details "* copyright: $copyright"
echo_details "* umbrella_header: $umbrella_header"

#
# Validate parameters
validate_required_input "project_path" $project_path
validate_required_input "language" $language
validate_required_input "author" $author
validate_required_input "sdk" $sdk
validate_required_input "version" $version
validate_required_input "framework_root" $framework_root
validate_required_input "module" $module
validate_required_input "acl" $acl
validate_required_input "output" $output

if [[ "$language" == "objc" ]]; then
	validate_required_input "umbrella_header" $umbrella_header
	BASE_COMMAND="--clean --objc --umbrella-header $umbrella_header"
else
	validate_required_input "scheme" $scheme
	BASE_COMMAND="--clean"
fi

if [[ -n "$jazzy_configuration" ]]; then
	CONFIG_PATH="$jazzy_configuration"
else
	CONFIG_PATH="$(pwd)/temp_jazzy_config.yaml"
	create_jazzy_config "$CONFIG_PATH" "$scheme" "$language" "$author"
fi

JAZZY="$(which jazzy)"

if [[ "$JAZZY" == "" || "$JAZY" == "jazzy not found" ]]; then
	gem install jazzy
fi

if [[ "$sdk" == "mac" || "$sdk" == "none" ]]; then
	DOC_SDK="macos"
else
	DOC_SDK="$(echo $sdk)simulator"
fi



if [[ -n "$title" ]]; then
	TITLE="$title"
else
	TITLE="$module"
fi

if [[ -n "$copyright" ]]; then
	COPYRIGHT="$copyright"
else
	COPYRIGHT="$module"
fi

echo "Running: "

echo "jazzy $BASE_COMMAND \
	--config \"$CONFIG_PATH\" \
	--author $author \
	--sdk $DOC_SDK \
	--module-version $version \
	--framework-root $framework_root \
	--module $module \
	--min-acl $acl \
	--output $output \
	$EXTRA_PARAMETERS"

jazzy $BASE_COMMAND \
	--config "$CONFIG_PATH" \
	--author $author \
	--sdk $DOC_SDK \
	--module-version $version \
	--framework-root $framework_root \
	--module $module \
	--min-acl $acl \
	--output $output \
	--title "$TITLE" \
	--readme "$readme" \
	--copyright "$COPYRIGHT"

if [[ ! -n "$jazzy_configuration" ]]; then
	rm "$CONFIG_PATH"
fi

export DOCUMENTATION_PATH="$output"



