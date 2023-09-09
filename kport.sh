#!/bin/sh
# Usage: List Depracated resources in any k8s cluster using kubent -> out all to json files.
# Author: vrahmanov sumpreme
# Usage: ./kubent_fetch_active_depracations.sh -v|--version 1.25
# INFOR: THIS CODE WILL LOOP OVER ALL KUBE CONTEXT SET IN USER 
# -------------------------------------------------
# minimum requirement
echo "creating a temp folder"
mkdir -p kport-tmp && cd kport-tmp
rm index.html || echo "couldnt find index.html"
function check_requirements
{

	command -v kubectx >/dev/null 2>&1 || {
		echo >&2 "I require kubectx but it's not installed.  Aborting."
		exit 1
	}
		command -v kubent >/dev/null 2>&1 || {
		echo >&2 "I require kubent but it's not installed.  Aborting."
		exit 1
	}
		command -v jq >/dev/null 2>&1 || {
		echo >&2 "I require jq but it's not installed.  Aborting."
		exit 1
		
	}

}
check_requirements

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -v|--version) version="$2"; shift ;;
        -t|--type) type="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ -z "$version" ]; then echo "Parameter target missing EXAMPLE: $0 --version 1.25" && exit 1; fi
if [ -z "$type" ]; then echo "Parameter target missing EXAMPLE: $0 --type CONTEXT_NAME " && exit 1; fi


function main {
for i in $(kubectx);do
	if [[ $i == "$type"* ]]; then
		printf "===== kubectx switching context to $i======\n"
		echo  "======================  $i  ======================" >> $FILE_NAME_GENERATED
		kubectx $i
		if test -z "$(kubent -t ${version} -o text -O $FILE_NAME_GENERATED)";then
			echo  "none" >> $FILE_NAME_GENERATED
		fi
	fi
done
}
echo "im at 60% "

cat << EOF >> index.html
<!doctype html>
<title>Whats about to change ? </title>
<style>
  body { text-align: center; padding: 110px; }
  h1 { font-size: 30px; }
  body { font: 20px Helvetica, sans-serif; color: #333; }
  article { display: block; text-align: left; width: 800px; margin: 0 auto; }
  a { color: #dc8100; text-decoration: none; }
  a:hover { color: #333; text-decoration: none; }
</style>
<meta http-equiv="refresh" content="3">
<article>
    <h1><img src="https://www.enterprisestorageforum.com/wp-content/uploads/2022/07/Kubernetes-logo-icon.png" alt="Image A"/> kubernethes depracations list in $version</h1>
    <div>
EOF

echo "im at 70% "

FILE_NAME_GENERATED="$type-depracated_in_$version.diffs"

function main {
for i in $(kubectx);do
	if [[ $i == "$type"* ]]; then
		printf "===== kubectx switching context to $i======\n"
		echo  "======================  $i  ======================" >> $FILE_NAME_GENERATED
		echo "<p>$i</p>" >> index.html
		kubectx $i

		if ! OUTPUT="$(kubent -t ${version} -o text)"; then       # check for non-zero return code first
			echo "kubent failed to run!"
		elif [ -n "${OUTPUT}" ]; then       # check for empty stdout
			echo "Deprecated resources found $OUTPUT"
			echo $OUTPUT >> $FILE_NAME_GENERATED
			echo "<p2>&#33; &#33; &#33; hmm... look at that</p2>" >> index.html
			echo "<pre id="json"> $OUTPUT</pre>" >> index.html
			# echo "<p1>$OUTPUT</p1>" >> index.html

		else
			echo  "none" >> $FILE_NAME_GENERATED
			echo "<p2>&#10003; None - All good</p2>" >> index.html
		fi
	fi
done
}
echo "im at 90% "

rm $FILE_NAME_GENERATED || echo "couldnt find $FILE_NAME_GENERATED "

main
cat << EOF >> index.html
		<p></p>
		<p></p>
		<p></p>
    </div>
</article>
<footer style="display:flex;justify-content:center"><div class="HeartApollorion_note__3CO5t"><p><span><a href="https://vrahmanov.github.io">View in GitHub</a></span> • <span>K8s Is Awesome</span> • <span>Made with <span>❤</span></span></p>
<p style="font-size:smaller;margin-top:5px">Authored by <a href="https://github.com/vrahmanov/">vrahmanov</a></p>
<p style="font-size:smaller;margin-top:5px">Design support by FREAKING GOOGLE 10th search page, literally hate html !!!</p></div></footer>
EOF
echo "done"
open ./index.html
