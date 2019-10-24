Class {
	#name : #CTHashBag,
	#superclass : #Bag,
	#category : #'Containers-Hashtable'
}

{ #category : #'instance creation' }
CTHashBag class >> contentsClass [
	^CTHashTable
]
