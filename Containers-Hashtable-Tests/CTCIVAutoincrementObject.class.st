Class {
	#name : #CTCIVAutoincrementObject,
	#superclass : #Object,
	#instVars : [
		'hash'
	],
	#classInstVars : [
		'nextHash'
	],
	#category : #'Containers-Hashtable-Tests-ObjectTester'
}

{ #category : #'class initialization' }
CTCIVAutoincrementObject class >> initialize [
	"self initialize"
	nextHash := 0
]

{ #category : #'instance creation' }
CTCIVAutoincrementObject class >> new [
	nextHash = SmallInteger maxVal ifTrue: [
		nextHash := 0 ].
	nextHash := nextHash + 1.
	^super new
		hash: nextHash;
		yourself
]

{ #category : #comparing }
CTCIVAutoincrementObject >> hash [
	^hash
]

{ #category : #private }
CTCIVAutoincrementObject >> hash: anObject [
	hash := anObject
]
