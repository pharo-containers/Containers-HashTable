Class {
	#name : #CTHashBag,
	#superclass : #Bag,
	#category : #'Containers-HashTable'
}

{ #category : #'instance creation' }
CTHashBag class >> contentsClass [
	^CTHashTable
]
