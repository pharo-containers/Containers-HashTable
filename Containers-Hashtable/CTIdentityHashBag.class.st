Class {
	#name : #CTIdentityHashBag,
	#superclass : #Bag,
	#category : #'Containers-Hashtable'
}

{ #category : #'instance creation' }
CTIdentityHashBag class >> contentsClass [
	^CTIdentityHashTable
]
