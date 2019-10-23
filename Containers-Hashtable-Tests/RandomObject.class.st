Class {
	#name : #RandomObject,
	#superclass : #Object,
	#instVars : [
		'hash'
	],
	#category : #'Containers-Hashtable-Tests-ObjectTester'
}

{ #category : #comparing }
RandomObject >> hash [
	^hash
]

{ #category : #'initialize-release' }
RandomObject >> initialize [
	super initialize.
	hash := SmallInteger maxVal atRandom
]
