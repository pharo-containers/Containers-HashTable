Class {
	#name : #CTIdentityHashTable,
	#superclass : #CTHashTable,
	#category : #'Containers-Hashtable'
}

{ #category : #private }
CTIdentityHashTable >> hashFor: anObject [
	^ anObject identityHash
]

{ #category : #private }
CTIdentityHashTable >> is: anObject sameAs: anotherObject [
	^ anObject == anotherObject
]
