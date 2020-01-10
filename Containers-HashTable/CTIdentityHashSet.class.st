"
Implementation:
copy methods from IdentifyHashTable here

Yes this is ugly, give me Traits and I will fix it.
"
Class {
	#name : #CTIdentityHashSet,
	#superclass : #CTHashSet,
	#category : #'Containers-HashTable'
}

{ #category : #private }
CTIdentityHashSet >> hashFor: anObject [
	^ anObject identityHash
]

{ #category : #private }
CTIdentityHashSet >> is: anObject sameAs: anotherObject [
	^ anObject == anotherObject
]
