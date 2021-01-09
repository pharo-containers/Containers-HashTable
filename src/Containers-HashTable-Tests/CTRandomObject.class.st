Class {
	#name : #CTRandomObject,
	#superclass : #Object,
	#instVars : [
		'hash'
	],
	#category : #'Containers-HashTable-Tests-ObjectTester'
}

{ #category : #comparing }
CTRandomObject >> hash [
	^hash
]

{ #category : #'initialize-release' }
CTRandomObject >> initialize [
	super initialize.
	hash := SmallInteger maxVal atRandom
]
