"
I'm `Bag` whose internal container is `CTIdentityHashTable`.
"
Class {
	#name : #CTIdentityHashBag,
	#superclass : #Bag,
	#category : #'Containers-HashTable-Bag'
}

{ #category : #'instance creation' }
CTIdentityHashBag class >> contentsClass [
	^CTIdentityHashTable
]
