# export the common variables from app inputs


$scriptpath = $MyInvocation.MyCommand.Path

$dir = Split-Path $scriptpath

cd $dir

echo "My current directory is ..."
pwd

cd ..\..\..\..\..\
. ./input.yaml

echo -n " ";
echo -n " ";
echo -n " ";

# call the deploy script
echo "The current working directory is ..."
pwd

echo -n " ";

echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo "Starting execution of deploy script ... "
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

# Calling msdeploy.exe using start-process to handle white spaces in commands, paths, and for handling aynscrhonous calls

$msdeploy = "C:\Program Files\IIS\Microsoft Web Deploy V3\msdeploy.exe"
$msdeployArgs = @(
  "-verb:sync",
  "-source:package='C:\Users\valla\OneDrive\Desktop\NewSampleApplication\WebApplication1\obj\Release\Package\WebApplication1.zip'",
  "-dest:auto",
  "-setParam:'IIS Web Application Name'='Default Web Site/App1'"
)
Start-Process $msdeploy -NoNewWindow -ArgumentList $msdeployArgs -wait

if ( $? )
{
  echo "Deploy script is executed successfully."
  exit 0
}
else
{
  echo "Deploy Failed"
  }
