Class {
	#name : #CTCVAutoincrementObject,
	#superclass : #Object,
	#instVars : [
		'hash'
	],
	#classVars : [
		'NextHash'
	],
	#category : #'Containers-HashTable-Tests-ObjectTester'
}

{ #category : #'class initialization' }
CTCVAutoincrementObject class >> initialize [
	"self initialize"
	NextHash := 0
]

{ #category : #comparing }
CTCVAutoincrementObject >> hash [
	^hash
]

{ #category : #'initialize-release' }
CTCVAutoincrementObject >> initialize [
	super initialize.
	NextHash = SmallInteger maxVal ifTrue: [
		NextHash := 0 ].
	NextHash := NextHash + 1.
	hash := NextHash
]
