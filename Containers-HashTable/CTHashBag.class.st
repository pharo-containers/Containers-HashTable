"
I'm `Bag` whose internal container is `CTHashTable`.
"
Class {
	#name : #CTHashBag,
	#superclass : #Bag,
	#category : #'Containers-HashTable-Bag'
}

{ #category : #'instance creation' }
CTHashBag class >> contentsClass [
	^CTHashTable
]
