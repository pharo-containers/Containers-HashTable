Class {
	#name : #CTWeakKeyTableItem,
	#superclass : #CTTableItem,
	#category : #'Containers-HashTable-Hash'
}

{ #category : #accessing }
CTWeakKeyTableItem >> key [
	^key first
]

{ #category : #accessing }
CTWeakKeyTableItem >> key: anObject [
	key := WeakArray with: anObject.
	keyHash := anObject hash.
]
