Class {
	#name : #CTObjectTester,
	#superclass : #Object,
	#instVars : [
		'instances'
	],
	#category : #'Containers-Hashtable-Tests-ObjectTester'
}

{ #category : #testing }
CTObjectTester class >> testAll [
	"self testAll"
	self new testAll
]

{ #category : #'initialize-release' }
CTObjectTester >> initialize [
	super initialize.
	self instances: 1000000
]

{ #category : #accessing }
CTObjectTester >> instances [
	^instances
]

{ #category : #accessing }
CTObjectTester >> instances: anInteger [ 
	instances := anInteger
]

{ #category : #testing }
CTObjectTester >> test: aClass on: aStream [
	aStream nextPutAll: aClass name.
	aStream tab.
	aStream nextPutAll: [
		1 to: self instances do: [ :each |
			aClass new ] ] timeToRun asString
]

{ #category : #testing }
CTObjectTester >> testAll [
	"self new testAll"
	
	| stream |
	stream := 'classes.creationdata' asFileReference writeStream.
	self testClasses
		do: [ :each | 
			Transcript show: 'Testing: '; show: each name; cr.
			self test: each on: stream]
		separatedBy: [ stream cr].
	stream close.
	Transcript show: 'done' ; cr
]

{ #category : #accessing }
CTObjectTester >> testClasses [
	^Array
		with: Object
		with: CTCVAutoincrementObject
		with: CTCIVAutoincrementObject		
		with: CTRandomObject
]
