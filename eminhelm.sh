#!/bin/bash
        chart=Chart.yaml
        length=$(yq '.dependencies | length' $chart)
        for j in $(seq $length $END); do 
            iter=$(($j-1))
            repo=$(yq .dependencies[$iter].repository $chart)
            name=$(yq .dependencies[$iter].name $chart)
            version=$(yq .dependencies[$iter].version $chart)
            app_version=$(yq .appVersion $chart)
            randomizer=$RANDOM
            # only if this app points to an external helm chart
            if helm repo add "auto-repo$iter$randomizer" $repo > /dev/null 2>&1
            then
                echo "add temp remote repo $name : auto-repo$iter$randomizer"
                helm repo update "auto-repo$iter$randomizer"
                available_version=$(helm search repo "auto-repo$iter$randomizer/$name" --versions | sed -n '2p' | awk '{print $2}')
                available_app_version=$(helm search repo "auto-repo$iter$randomizer/$name" --versions | sed -n '2p' | awk '{print $3}')
                if [ "$available_version" != "$version" ]; then
                    echo "Repository: $repo"
                    echo "Chart name: $name"
                    echo "Local chart version: $version Available version: $available_version"
                    echo "Local app version: $app_version Available version: $available_app_version"
                    helm pull "auto-repo$iter$randomizer/$name" --version $version --untar --untardir ./compare-repo-$name/$version
                    helm template --generate-name ./compare-repo-$name/$version/$name  > $name-$version.yaml 
                    helm pull "auto-repo$iter$randomizer/$name" --version $available_version --untar --untardir ./compare-repo-$name/$available_version
                    helm template --generate-name ./compare-repo-$name/$available_version/$name  > $name-$available_version.yaml 
#                     diff --color $name-$version.yaml $name-$available_version.yaml > ../../../$k-$name-$version-$available_version.diff
#                     yq e '.dependencies['$iter'].version |= sub("'$version'", "'$available_version'")' -i $chart               
#                     yq e '.version |= sub("'$version'", "'$available_version'")' -i $chart    
#                     yq e '.appVersion |= sub("'$app_version'", "'$available_app_version'")' -i $chart
                    echo                    
                    rm $name-$available_version.yaml $name-$version.yaml || echo "tried removing some temp files $name-$available_version.yaml $name-$version.yaml but couldnt findthem"
                    rm -rf ./compare-repo-$name/ || echo "tried removing some temp files /compare-repo-$name/$version but couldnt findthem"
                else
                    echo "couldnt find newer version"
                    echo "remove temp remote $name : auto-repo$iter$randomizer " && helm repo remove auto-repo$iter$randomizer > /dev/null 2>&1
                    echo
                fi
            fi
            done