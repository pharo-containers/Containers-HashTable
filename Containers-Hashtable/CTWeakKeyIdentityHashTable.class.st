Class {
	#name : #CTWeakKeyIdentityHashTable,
	#superclass : #CTWeakKeyHashTable,
	#category : #'Containers-HashTable'
}

{ #category : #private }
CTWeakKeyIdentityHashTable >> hashFor: anObject [
	^ anObject identityHash
]

{ #category : #private }
CTWeakKeyIdentityHashTable >> is: anObject sameAs: anotherObject [
	^ anObject == anotherObject
]
