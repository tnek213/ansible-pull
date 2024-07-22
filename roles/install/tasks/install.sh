#!/bin/sh

package=
distribution_version=
distribution_major_version=
distribution=
distribution_release=
os_family=
pkg_mgr=

# Arguments are in the form of key=value pairs which will be set as variables
# in the script. The values are sanitized to remove any non-alphanumeric
# characters and converted to lowercase.
for arg
do
    if [ "${arg##*=}" = "NA" ] || [ "${arg##*=}" = "" ]; then
        arg=""
    fi
    arg=$(printf "%s" "$arg" | tr -c -s '[:alnum:]=' '_' | tr '[:upper:]' '[:lower:]')
    eval "$arg"
done

dist_id=${distribution:-$distribution_release}

for tasks_file in "dist_${dist_id}_${distribution_version}" "dist_${dist_id}_${distribution_major_version}" "dist_${dist_id}" "fam_${os_family}" "pkg_${pkg_mgr}"
do
    tasks_file="${package}_${tasks_file}.yml"

    # Skip files with missing variables
    echo "$tasks_file" | grep -q -E "_[_.]" && continue

    echo "Looking for: $tasks_file" >&2
    if [ -f "$tasks_file" ]
    then
        echo "$tasks_file"
        exit 0
    fi
done

echo "Error: No tasks file found!" >&2
exit 1
