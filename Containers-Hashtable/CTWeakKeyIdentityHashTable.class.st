Class {
	#name : #CTWeakKeyIdentityHashTable,
	#superclass : #CTWeakKeyHashTable,
	#category : #'Containers-Hashtable'
}

{ #category : #private }
CTWeakKeyIdentityHashTable >> hashFor: anObject [
	^ anObject identityHash
]

{ #category : #private }
CTWeakKeyIdentityHashTable >> is: anObject sameAs: anotherObject [
	^ anObject == anotherObject
]
