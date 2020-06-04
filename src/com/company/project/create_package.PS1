#This script will build the dll from source code
# export the common variables from app inputs


#Export the common variables
param(
[string]$WORKSPACE,
[string]$project_file,
[string]$published_path,
      [string]$APP_name


)


echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo "Starting execution of build script ...... "
echo "$WORKSPACE"
echo "$project_file"
echo "$published_path"
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"



#& 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe' C:\Users\valla\OneDrive\Desktop\NewSampleApplication\WebApplication1.sln /p:Configuration=Release  /t:Package
& 'C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe' $WORKSPACE/$project_file /p:Configuration=Release  /t:Package

#$destination = "C:\Program Files (x86)\Jenkins\workspace\dotnet\WebApp1\WebApp1\obj"

#$output_path = "$destination"
#$check_path = Test-path "$output_path"

if ( $? )
{
echo "Package script is executed successfully."
exit 0
}
else
{
echo "Deploy script is FAILED."
exit 1
}

echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo "Execution of Package Script is Completed "
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"


echo -n " "
echo -n " "
echo -n " "
