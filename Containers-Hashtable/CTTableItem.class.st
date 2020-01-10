Class {
	#name : #CTTableItem,
	#superclass : #Object,
	#instVars : [
		'key',
		'value',
		'keyHash',
		'next'
	],
	#category : #'Containers-HashTable'
}

{ #category : #'instance creation' }
CTTableItem class >> key: aKey value: aValue [
	^self new
		key: aKey;
		value: aValue;
		yourself.
]

{ #category : #'instance creation' }
CTTableItem class >> key: aKey value: aValue next: anItem [
	^self new
		key: aKey;
		value: aValue;
		next: anItem;
		yourself.
]

{ #category : #accessing }
CTTableItem >> key [
	^key
]

{ #category : #accessing }
CTTableItem >> key: anObject [
	key := anObject
]

{ #category : #accessing }
CTTableItem >> keyHash [
	^keyHash
]

{ #category : #accessing }
CTTableItem >> keyHash: anIngeter [ 
	keyHash := anIngeter
]

{ #category : #accessing }
CTTableItem >> next [
	^next
]

{ #category : #accessing }
CTTableItem >> next: anObject [
	next := anObject
]

{ #category : #copying }
CTTableItem >> postCopy [
	super postCopy.
	next isNil ifFalse: [
		next := next copy ]
]

{ #category : #printing }
CTTableItem >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' key: ';
		nextPutAll: self key asString;
		nextPutAll: ' value: ';
		nextPutAll: self value asString.
]

{ #category : #public }
CTTableItem >> setAsNil [
	self next: nil.
	self key: nil.
	self keyHash: nil.
	self value: nil.
]

{ #category : #accessing }
CTTableItem >> value [
	^value
]

{ #category : #accessing }
CTTableItem >> value: anObject [
	value := anObject
]
