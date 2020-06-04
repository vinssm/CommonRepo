#!/bin/groovy

package com.company.project;

	public def getVersionNumber(String versionFilePath) {
		def props = readProperties file: versionFilePath
		return props['appVersion']
	}

	public def getCommitMessage() {
		def commitMessage = bat(script: '@git log --pretty=format:\'%%h\' -n 1', returnStdout: true)
		return commitMessage
	}


	public def PowerShell(psCmd) {
	    psCmd=psCmd.replaceAll("%", "%%")
	        bat "powershell.exe -NonInteractive -ExecutionPolicy Bypass -Command \"\$ErrorActionPreference='Stop';[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$psCmd;EXIT \$global:LastExitCode\""
		}

	public def build(String WORKSPACE, String project_file) {
		echo "@@@@@@ Startint the Powershell Script for code build @@@@@@"
		echo "####### ${WORKSPACE} ######################"
		echo "####### ${project_file} ######################"
		echo "Starting the poweshell script for building ...... "
		PowerShell(". 'CommonRepo\\src\\com\\company\\project\\build.PS1' '$WORKSPACE $project_file'")
	}
	public def executeUnitTests() {
		echo "Executing the Unit tests. executing script from Common repo ... "
		PowerShell(". 'CommonRepo\\src\\com\\company\\project\\unit_tests.PS1'")
	}
	public def uploadToArtifactory() {
		echo "Uploading to Artifactory. executing script from Common repo ... "
		PowerShell(". 'CommonRepo\\src\\com\\company\\project\\upload_artifact.PS1'")
	}

	public def build() {
		echo "Starting the poweshell script for creating package ... "
		PowerShell(". 'CommonRepo\\src\\com\\company\\project\\build.PS1'")
		}

	public def create_package(String WORKSPACE, String project_file, String published_path) {
		echo "========= Starting the poweshell script for creating package ......... "
		echo "####### ${WORKSPACE} ######################"
		echo "####### ${project_file} ######################"
		echo "####### ${published_path} ######################"
		PowerShell(". 'CommonRepo\\src\\com\\company\\project\\create_package.PS1' '$WORKSPACE $project_file $published_path'")
		}
		public def web_deploy() {
			echo "Starting the poweshell script for extracting packages into web deploy directory ... "
			PowerShell(". 'CommonRepo\\src\\com\\company\\project\\web_deploy.PS1'")
		}



	public void writeVersionToFile(String versionFilePath, String version) {
		Properties props = new Properties()
		File propsFile = new File(versionFilePath)
		DataInputStream dis = propsFile.newDataInputStream()
		BufferedWriter bw = propsFile.newWriter()
		props.load(dis)
		props.setProperty('appVersion', version)
		props.store(bw, null)
		bw.close()
		dis.close()
	}


	public void notifySuccess() {
		emailext (
			subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
			body: '${JELLY_SCRIPT, template="html"}',
			mimeType: 'text/html',
			to: "vallab.v@gmail.com",
			from: "company project DevOps <project.devops@company.com>",
			replyTo: "vallab.v@gmail.com",
			//recipientProviders: [[$class: 'DevelopersRecipientProvider']]
		)
	}

	public void notifyFailure() {
		emailext (
			subject: "Failure: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
			body: '${JELLY_SCRIPT, template="html"}',
			mimeType: 'text/html',
			to: "vallab.v@gmail.com",
			from: "company project DevOps <project.devops@company.com>",
			replyTo: "vallab.v@gmail.com",
			//recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'CulpritsRecipientProvider'],
				//[$class: 'FailingTestSuspectsRecipientProvider'], [$class: 'RequesterRecipientProvider'], [$class: 'UpstreamComitterRecipientProvider']]
		)
	}

	public void emailDownloadLink(String artifactUrl) {
		emailext (
			subject: "Build Release: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
			body: "URL: $artifactUrl",
			mimeType: 'text/html',
			to: "vallab.v@gmail.com",
			from: "company project DevOps <project.devops@company.com>",
			replyTo: "vallab.v@gmail.com",
			//recipientProviders: [[$class: 'DevelopersRecipientProvider']]
		)
	}
