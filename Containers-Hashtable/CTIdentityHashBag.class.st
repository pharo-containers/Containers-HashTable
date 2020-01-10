Class {
	#name : #CTIdentityHashBag,
	#superclass : #Bag,
	#category : #'Containers-HashTable'
}

{ #category : #'instance creation' }
CTIdentityHashBag class >> contentsClass [
	^CTIdentityHashTable
]
