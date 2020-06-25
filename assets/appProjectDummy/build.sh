rootFolder="$(cat ./doNotTouch/rootFolder.txt)"
appFolder="$(pwd)"
appId=$(cat ./doNotTouch/appId.txt)

mkdir ./static
rm ./static/*.*

#Make the home widget work
echo CACHE MANIFEST > ./doNotTouch/manifest.appcache
echo /apps/home/config/standardApps.json >> ./doNotTouch/manifest.appcache
echo /apps/home/config/developerApps.json >> ./doNotTouch/manifest.appcache

#Generate static string assets and translationMap.json for quick access, as well as manifest.appcache
hasPrevious=0
for jsonFile in $(find "$appFolder" -name default.json)
do
	parent="$(dirname $jsonFile)"
	sum=($(shasum "$jsonFile"))
	echo $sum
	cat "$jsonFile" > ./static/$sum.json
	
	key='"'$(basename $parent)'"'
	value='"'$sum'"'
	if [ $hasPrevious == 1 ]
	then
		echo ,$key:$value >> ./doNotTouch/translationMap.json
	else
		echo {$key:$value > ./doNotTouch/translationMap.json
		hasPrevious=1
	fi
	echo ../static/$sum.json >> ./doNotTouch/manifest.appcache
done
if [ $hasPrevious == 1 ]
then
	echo "}" >> ./doNotTouch/translationMap.json
else
	rm ./doNotTouch/translationMap.json
	rm ./doNotTouch/manifest.appcache
	rm ./doNotTouch/appcache-manifest.txt
fi


#Generate app .json file (read by HTML building); continues for many lines
echo "{" > ./$appId.json
hasPrevious=0

#excludedLibraries
if [ -f "./config/excluded-libraries.json" ]
then
	echo "\"excludedLibraries\":$(cat ./config/excluded-libraries.json)" >> ./$appId.json
	hasPrevious=1
fi
#iOS icon
if [ -f "./icons/iOS.png" ]
then
	if [ $hasPrevious == 1 ]
	then
		echo "," >> ./$appId.json
	fi
	#Build static version of iOS.png
	sum=($(shasum "./icons/iOS.png"))
	cat ./icons/iOS.png > ./static/$sum.png
	echo "\"appleTouchIcon\":\"/apps/$appId/static/$sum.png\"" >> ./$appId.json
	echo "../static/$sum.png" >> ./doNotTouch/manifest.appcache
fi
#Standard icons
for file in $(ls "$rootFolder/assets/images/static"); do
	echo "/assets/images/static/$file" >> ./doNotTouch/manifest.appcache
done
#Default language file
echo "/assets/strings/default.json" >> ./doNotTouch/manifest.appcache
#Application Cache (should be the last item)
echo NETWORK: >> ./doNotTouch/manifest.appcache
echo "*" >> ./doNotTouch/manifest.appcache

##Build static version of manifest.appcache
sum=($(shasum "./doNotTouch/manifest.appcache"))
appBaseSum=($(shasum "$rootFolder/generated/_browser_app_singlefile.html"))
appCodeSum=($(shasum "$appFolder/$appId.k"))
cat ./doNotTouch/manifest.appcache > ./static/$sum-$appBaseSum-$appCodeSum.appcache
echo "/apps/$appId/static/$sum-$appBaseSum-$appCodeSum.appcache" > ./doNotTouch/appcache-manifest.txt
##Actually include it in app .json
if [ -f "./doNotTouch/appcache-manifest.txt" ]
then
	if [ $hasPrevious == 1 ]
	then
		echo "," >> ./$appId.json
	fi
	echo "\"appcacheManifest\":\"$(cat ./doNotTouch/appcache-manifest.txt)\"" >> ./$appId.json
fi

#End of app .json file generation
echo "}" >> ./$appId.json


#Build the actual HTML file
cd "$rootFolder/nodejs/files"

if [ -f "$appFolder/platform-packages.json" ]
	then
		bash ./run.sh "$rootFolder/nodejs/files/minifyKalzitPackage.txt" --input-file "$appFolder/platform-packages.json" --output-file "$appFolder/doNotTouch/_min.js"
	else
		rm "$appFolder/doNotTouch/_min.js"
	fi


bash "$rootFolder/utilities/cli/build/kalzitFile.sh" "$appFolder/$appId.k" "$rootFolder"