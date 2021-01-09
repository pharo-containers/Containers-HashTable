Class {
	#name : #CTHashTable,
	#superclass : #Collection,
	#instVars : [
		'table',
		'loadfactor',
		'size',
		'capacity'
	],
	#category : #'Containers-HashTable-Hash'
}

{ #category : #'as yet unclassified' }
CTHashTable class >> asFileSizeString: bytes [
    | units exp |
    units := #(' B'  ' KB' ' MB' ' GB' ' TB' ' PB').
    exp := bytes floorLog: 1024.
    ^((bytes asFloat / (1024 raisedTo: exp))
        printShowingDecimalPlaces: 1) , (units at: exp + 1)
]

{ #category : #'instance creation' }
CTHashTable class >> capacity: aCapacity [
	^self capacity: aCapacity loadfactor: 0.6
]

{ #category : #'instance creation' }
CTHashTable class >> capacity: anInteger loadfactor: aFloat [
	| size table |
	size := (anInteger / aFloat) asInteger.
	table := Array new: size.
	^ super new
		capacity: anInteger;
		setLoadfactor: aFloat;
		table: table;
		yourself.
]

{ #category : #'instance creation' }
CTHashTable class >> new [
	^self capacity: 10
]

{ #category : #'instance creation' }
CTHashTable class >> new: anInteger [
	^self capacity: anInteger
]

{ #category : #comparing }
CTHashTable >> = aDictionary [
	"Two dictionaries are equal if
	 (a) they are the same 'kind' of thing.
	 (b) they have the same set of keys.
	 (c) for each (common) key, they have the same value"

	((aDictionary isKindOf: Dictionary) or: [aDictionary isKindOf: CTHashTable])
		ifFalse: [^false].
	self size = aDictionary size ifFalse: [^false].
	self keysAndValuesDo: [ :key :value |
		(aDictionary at: key ifAbsent: [^false]) = value
			ifFalse: [^false]].
	^true
]

{ #category : #adding }
CTHashTable >> add: anAssociation [
	"Add a new entry in the receiver based on the argument. The key of the entry is the key of anAssociation and the value the value of anAssociation."
	^ self at: anAssociation key put: anAssociation value
]

{ #category : #adding }
CTHashTable >> add: anAssociation withOccurrences: anInteger [
	"Add anAssociation one time to the receiver because it does not make sense to add several time the same key/value to a dictionary."
	
	anInteger < 1 ifTrue: [ ^ anAssociation ].
	"I can only store an object once."
	^ self add: anAssociation
]

{ #category : #adding }
CTHashTable >> addAll: aKeyedCollection [
	aKeyedCollection == self ifFalse: [
		aKeyedCollection keysAndValuesDo: [ :key :value |
			self at: key put: value ] ].
	^aKeyedCollection
]

{ #category : #private }
CTHashTable >> addAllOf: anItem to: aTable [
	| item oldNext |
	item := anItem.
	[ item notNil ]
		whileTrue: [
			oldNext := item next.
			self addItem: item to: aTable.
			item := oldNext ].
]

{ #category : #private }
CTHashTable >> addItem: anItem to: aTable [
	| index |
	index := self computeIndexFromHash: anItem keyHash forTable: aTable.
	anItem next: (aTable at: index).
	aTable at: index put: anItem.
]

{ #category : #private }
CTHashTable >> addKey: aKey value: aValue [
	| item newSize index |
	newSize := self size + 1.
	self ensureCapacity: newSize.
	index := self computeIndex: aKey.
	item := self itemClass key: aKey value: aValue next: (self table at: index).
	item keyHash: (self hashFor: aKey).
	self table at: index put: item.
	self size: newSize.
]

{ #category : #accessing }
CTHashTable >> associationAt: key [
	^ self
		associationAt: key
		ifAbsent: [ self errorKeyNotFound ]
]

{ #category : #accessing }
CTHashTable >> associationAt: key ifAbsent: aBlock [ 
	^ key -> (self at: key ifAbsent: [ ^aBlock value ])
]

{ #category : #enumerating }
CTHashTable >> associationsDo: aBlock [
	self keysAndValuesDo: [ :key :value |
		aBlock value: key -> value ]
]

{ #category : #accessing }
CTHashTable >> at: aKey [
	^self at: aKey ifAbsent: [ self errorKeyNotFound ]
]

{ #category : #accessing }
CTHashTable >> at: aKey ifAbsent: aBlock [
	| index item |
	index := self computeIndex: aKey.
	item := self itemFor: aKey atIndex: index.
	^ item isNil
		ifTrue: [ aBlock value ]
		ifFalse: [ item value ].
]

{ #category : #accessing }
CTHashTable >> at: key ifAbsentPut: aBlock [ 
	"Return the value at the given key. 
	If key is not included in the receiver store the result 
	of evaluating aBlock as new value."

	^ self
		at: key
		ifAbsent: [
			self
				at: key
				put: aBlock value ]
]

{ #category : #accessing }
CTHashTable >> at: key ifPresent: aBlock [
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer nil."

	| v |
	v := self at: key ifAbsent: [^ nil].
	^ aBlock value: v
]

{ #category : #adding }
CTHashTable >> at: aKey put: aValue [	
	| index item |
	index := self computeIndex: aKey.
	item := self itemFor: aKey atIndex: index.
	item isNil
		ifTrue: [ self addKey: aKey value: aValue ]
		ifFalse: [ item value: aValue ].
	^aValue
]

{ #category : #accessing }
CTHashTable >> capacity [
	^capacity
]

{ #category : #private }
CTHashTable >> capacity: anObject [
	capacity := anObject
]

{ #category : #enumerating }
CTHashTable >> collect: aBlock [ 
	"Evaluate aBlock with each of my values as the argument.  Collect the
	resulting values into a collection that is like me. Answer with the new
	collection."
	| newCollection |
	newCollection := OrderedCollection new: self size.
	self do: [:each | newCollection add: (aBlock value: each)].
	^ newCollection
]

{ #category : #private }
CTHashTable >> computeIndex: anObject [
	^ self computeIndexFromHash: (self hashFor: anObject) forTable: self table.
]

{ #category : #private }
CTHashTable >> computeIndexFromHash: aHash forTable: aTable [
	^ (aHash \\ aTable size) + 1.
]

{ #category : #private }
CTHashTable >> computeNewSize: minimum [
	^minimum max: (self table size * 2) + 1.
	
]

{ #category : #private }
CTHashTable >> decrementSize [
	self size: self size - 1
]

{ #category : #enumerating }
CTHashTable >> do: aBlock [
	self valuesDo: aBlock
]

{ #category : #private }
CTHashTable >> ensureCapacity: anInteger [
	"Returns if the table had to grow"
	
	self capacity < anInteger
		ifTrue: [
			self growTo: (self computeNewSize: anInteger).
			^ true ]
		ifFalse: [ ^false ].
]

{ #category : #private }
CTHashTable >> errorKeyNotFound [
	self error: 'key not found'
]

{ #category : #private }
CTHashTable >> growTo: anInteger [	
	| array |
	anInteger <= self table size ifTrue: [ self error: 'oops' ].
	array := Array new: anInteger.
	self table do: [ :each |
		self addAllOf: each to: array ].
	self table: array.
	self capacity: (anInteger * self loadfactor) asInteger
]

{ #category : #private }
CTHashTable >> hashFor: anObject [
	^ anObject hash
]

{ #category : #testing }
CTHashTable >> includesKey: aKey [

	self at: aKey ifAbsent: [ ^false ].
	^true.
]

{ #category : #initialization }
CTHashTable >> initialize [
	super initialize.
	self size: 0.
]

{ #category : #private }
CTHashTable >> is: anObject sameAs: anotherObject [
	^ anObject = anotherObject
]

{ #category : #private }
CTHashTable >> itemClass [
	^CTTableItem
]

{ #category : #private }
CTHashTable >> itemFor: aKey atIndex: anInteger [
	| item |
	item := self table at: anInteger.
	[ (item isNil or: [ self is: item key sameAs: aKey ]) not ]
		whileTrue: [ item := item next ].
	^item
]

{ #category : #accessing }
CTHashTable >> keys [
	"Answer a Collection containing the receiver's values."
	
	| out |
	out := WriteStream on: (Array new: self size).
	self keysDo: [:value | out nextPut: value].
	^ out contents
]

{ #category : #enumerating }
CTHashTable >> keysAndValuesDo: aBlock [
	self table do: [ :each |
		| current |
		current := each.
		[ current notNil ] whileTrue:  [
			aBlock value: current key value: current value.
			current := current next ] ]
]

{ #category : #enumerating }
CTHashTable >> keysDo: aBlock [
	self keysAndValuesDo: [ :key :value |
		aBlock value: key ]
]

{ #category : #accessing }
CTHashTable >> keysSortedSafely [
	"Answer a SortedCollection containing the receiver's keys."
	| sortedKeys |
	sortedKeys := SortedCollection new: self size.
	sortedKeys sortBlock:
		[:x :y |  "Should really be use <obj, string, num> compareSafely..."
			[ x < y ]
				ifError: [x printString < y printString] ].
	self keysDo: [ :each | sortedKeys add: each].
	^ sortedKeys
]

{ #category : #accessing }
CTHashTable >> loadfactor [
	^loadfactor
]

{ #category : #accessing }
CTHashTable >> loadfactor: aFloat [ 
	loadfactor := aFloat.
	self ensureCapacity: (self capacity / self loadfactor) asInteger.
]

{ #category : #copying }
CTHashTable >> postCopy [
	super postCopy.
	table := table collect: [ :each |
		each copy ]
]

{ #category : #printing }
CTHashTable >> printElementsOn: aStream [
	aStream nextPut: $(.
	self keysSortedSafely do:
		[:key | aStream print: key; nextPutAll: '->'; print: (self at: key); space].
	aStream nextPut: $)
]

{ #category : #private }
CTHashTable >> removeItemWithKey: aKey from: anItem ifAbsent: aBlock [
	| nextItem value |	
	nextItem := anItem next.
	^nextItem isNil
		ifTrue: [ aBlock value ]
		ifFalse: [ 
			(self is: nextItem key sameAs: aKey)
				ifTrue: [
					anItem next: nextItem next.
					value := nextItem value.
					self decrementSize.
					nextItem setAsNil.
					value ]
				ifFalse: [
					self removeItemWithKey: aKey from: nextItem ifAbsent: aBlock ] ].
	
]

{ #category : #removing }
CTHashTable >> removeKey: aKey [
	^self removeKey: aKey ifAbsent: [ self errorKeyNotFound ]
]

{ #category : #removing }
CTHashTable >> removeKey: aKey ifAbsent: aBlock [
	| index item value |
	index := self computeIndex: aKey.
	item := self table at: index.	 
	^item isNil
		ifTrue: [ aBlock value ]
		ifFalse: [ 
			(self is: item key sameAs: aKey)
				ifTrue: [
					self table at: index put: item next.
					value := item value.
					item setAsNil.
					self decrementSize.
					value ]
				ifFalse: [
					self removeItemWithKey: aKey from: item ifAbsent: aBlock ] ].
]

{ #category : #enumerating }
CTHashTable >> select: aBlock [ 
	"Evaluate aBlock with each of my values as the argument. Collect into a
	new dictionary, only those associations for which aBlock evaluates to
	true."

	| newCollection |
	newCollection := self species new.
	self keysAndValuesDo: [ :key :value | 
		(aBlock value: value)
			ifTrue: [ newCollection at: key put: value ] ].
	^newCollection
]

{ #category : #private }
CTHashTable >> setLoadfactor: aFloat [ 
	loadfactor := aFloat
]

{ #category : #accessing }
CTHashTable >> size [
	^size
]

{ #category : #private }
CTHashTable >> size: anInteger [
	size := anInteger
]

{ #category : #private }
CTHashTable >> table [
	^table
]

{ #category : #private }
CTHashTable >> table: anObject [
	table := anObject
]

{ #category : #accessing }
CTHashTable >> values [
	"Answer a Collection containing the receiver's values."
	| out |
	out := WriteStream on: (Array new: self size).
	self valuesDo: [:value | out nextPut: value].
	^ out contents
]

{ #category : #enumerating }
CTHashTable >> valuesDo: aBlock [
	self keysAndValuesDo: [ :key :value |
		aBlock value: value ]
]

{ #category : #private }
CTHashTable >> withTable: anArray [
	"private -- for use only in copy"
	table := anArray
]
