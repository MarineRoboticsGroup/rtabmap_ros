pipeline {
	agent { 
		dockerfile {
			args '-e HOME=$WORKSPACE'
			additionalBuildArgs '--build-arg USER_ID=$(id -u)'
		}
	}
	stages {
		stage('Build') {
			steps {
				sh '''#!/bin/bash -l
mkdir -p rtabmap_ros
mv * rtabmap_ros
mkdir -p src
mv rtabmap_ros src
catkin init
catkin config --merge-devel
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
source /opt/ros/melodic/setup.bash
catkin build
				'''
			}
		}
		stage('Test') {
			steps {
				echo 'Testing...'
				echo 'Run unit tests here'
			}
		}
		stage('Deploy') {
			steps {
				echo 'Deploying....'
				echo 'Run on datasets (can this be done locally with docker?)'
				echo '... we think so! We are trying to figure this out. Stay tuned.'
			}
		}
	}
	post {
		cleanup {
			cleanWs()
		}
	}
}
		
