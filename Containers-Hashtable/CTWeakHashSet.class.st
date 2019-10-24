Class {
	#name : #CTWeakHashSet,
	#superclass : #CTHashSet,
	#category : #'Containers-Hashtable'
}

{ #category : #enumerating }
CTWeakHashSet >> do: aBlock [
	self table withIndexDo: [ :each :index |
		| current |
		self fixAt: index.
		current := each.
		[ current notNil ]
			whileTrue: [
				current key ifNotNil: [ :key |
					aBlock value: key ].
				current := current next ] ]
]

{ #category : #private }
CTWeakHashSet >> fixAt: anInteger [
	"remove all items at an index in the table who's key is garbage collected"
	| item lastItem |
	item := self table at: anInteger.
	
	[ item notNil and: [item key isNil ] ]
		whileTrue: [
			item := item next.
			self table at: anInteger put: item.
			self decrementSize ].
		
	item := self table at: anInteger.
	lastItem := item.
	[ item notNil ]
		whileTrue: [ 
			lastItem := item.
			item := item next.			
						
			[ item notNil and: [ item key isNil ] ]
				whileTrue: [
					item := item next.
					lastItem next: item.
					self decrementSize ] ].
]

{ #category : #private }
CTWeakHashSet >> itemClass [
	^CTWeakKeyTableItem
]

{ #category : #private }
CTWeakHashSet >> itemFor: aKey atIndex: anInteger [
	| item |
	
	self fixAt: anInteger.
	item := self table at: anInteger.	
		
	[ item notNil ]
		whileTrue: [
			(self is: item key sameAs: aKey)
				ifTrue: [ ^item ].
			item := item next ].
	^nil
]
