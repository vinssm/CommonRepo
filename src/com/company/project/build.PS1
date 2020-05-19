#This script will build the dll from source code
# export the common variables from app inputs


#Export the common variables
param(
[string]$WORKSPACE,
[string]$project_file,
      [string]$APP_name


)


echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo "Starting execution of build script ...... "
echo "$WORKSPACE"
echo "$project_file"
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"



# echo "executing C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.com' C:\Users\valla\OneDrive\Desktop\NewSampleApplication\WebApplication1.sln -build ... "
& 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe' $WORKSPACE/$project_file COPY --from=publish /app/publish 

if ( $? )
{
echo "Build script is executed successfully."
exit 0
}
else

echo "Build script is FAILED."
exit 1
}

echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
echo "Execution of build script is completed "
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

