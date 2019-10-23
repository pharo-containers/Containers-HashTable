Class {
	#name : #HashBag,
	#superclass : #Bag,
	#category : #'Containers-Hashtable'
}

{ #category : #'instance creation' }
HashBag class >> contentsClass [
	^HashTable
]
