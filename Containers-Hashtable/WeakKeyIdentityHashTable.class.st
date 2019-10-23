Class {
	#name : #WeakKeyIdentityHashTable,
	#superclass : #WeakKeyHashTable,
	#category : #'Containers-Hashtable'
}

{ #category : #private }
WeakKeyIdentityHashTable >> hashFor: anObject [
	^ anObject identityHash
]

{ #category : #private }
WeakKeyIdentityHashTable >> is: anObject sameAs: anotherObject [
	^ anObject == anotherObject
]
