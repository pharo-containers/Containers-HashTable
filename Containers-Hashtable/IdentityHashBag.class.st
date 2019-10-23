Class {
	#name : #IdentityHashBag,
	#superclass : #Bag,
	#category : #'Containers-Hashtable'
}

{ #category : #'instance creation' }
IdentityHashBag class >> contentsClass [
	^IdentityHashTable
]
