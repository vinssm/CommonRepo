 # call the build script
# export the common variables from app inputs

$scriptpath = $MyInvocation.MyCommand.Path

$dir = Split-Path $scriptpath

cd $dir

cd ..\..\..\..\..\

. ./input.yaml


echo -n " "
echo -n " "
echo -n " "
pwd


echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo "Starting execution of Deploy script  ... "
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"



& 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe' C:\Users\valla\OneDrive\Desktop\NewSampleApplication\WebApplication1.sln /p:Configuration=Release  /t:Package

if ( $? )
{
echo "Deploy script is executed successfully."
exit 0
}
else
{
echo "Deploy script is FAILED."
exit 1
}

echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo "Execution of deploy script is completed "
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"


echo -n " "
echo -n " "
echo -n " "
