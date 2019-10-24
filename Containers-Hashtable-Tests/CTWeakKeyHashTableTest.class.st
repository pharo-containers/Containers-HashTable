Class {
	#name : #CTWeakKeyHashTableTest,
	#superclass : #TestCase,
	#instVars : [
		'table',
		'testsize'
	],
	#category : #'Containers-Hashtable-Tests-SUnit'
}

{ #category : #running }
CTWeakKeyHashTableTest >> setUp [
	super setUp.
	table := CTWeakKeyHashTable new.
	testsize := 100.
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testAddAll [
	"(self run: #testAddAll)"
	
	|  table2 |
	table at: #a put:1.
	table at: #b put: 2. 
	
	table2 := table species new.
	table2 at: #a put: 3.
	table2 at: #c put: 4.
	
	table addAll: table2.
	self assert: (table at: #a) = 3.
	self assert: (table at: #b) = 2.
	self assert: (table at: #c) = 4.
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testAddAssoc [
	0 to: testsize do: [ :each |
		self assert: table size = each.
		table add: each -> each asString ].
	0 to: testsize do: [ :each |
		self assert: (table at: each) = each asString ].
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testAddCopy [
	| table2 |
	0 to: testsize do: [ :each |
		table add: each -> each asString ].
	table2 := table copy.
	table2 at: testsize + 1 put: true.
	self assert: (table2 includesKey: testsize + 1).
	self deny: (table includesKey: testsize + 1).
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testAddInteger [
	0 to: testsize do: [ :each |
		self assert: table size = each.
		table at: each put: each asString ].
	0 to: testsize do: [ :each |
		self assert: (table at: each) = each asString ].
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testAddNil [
	self deny: (table includesKey: nil).
	self should: [ table at: nil put: 'nil' ] raise: Error.
	self deny: (table includesKey: nil) = 'nil'.
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testAddString [
	| keys |
	keys := (0 to: testsize) collect: [ :each | each asString ].
	keys do: [ :each |
		self assert: table size = each asNumber.
		table at: each put: each asNumber ].
	keys := (0 to: testsize) collect: [ :each | each asString ].
	keys do: [ :each |
		self assert: (table at: each ) = each asNumber ].
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testComma [
	"(self run: #testComma)"
	
	| table1 table2 |
	table at: #a put:1.
	table at: #b put: 2. 
	
	table1 := table species new.
	table1 at: #a put: 3.
	table1 at: #c put: 4.
	
	table2 := table, table1.
	self assert: (table2 at: #a) = 3.
	self assert: (table2 at: #b) = 2.
	self assert: (table2 at: #c) = 4.
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testEqualsDictionary [
	| dictionary |
	dictionary := Dictionary new.
	0 to: testsize do: [ :each |
		dictionary at: each put: each asString.
		table at: each put: each asString ].
	
	self assert: table = dictionary
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testEqualsTransitive [
	| table2 |
	table2 := table species new.
	0 to: testsize do: [ :each |
		table2 at: each put: each asString.
		table at: each put: each asString ].
	
	self assert: table = table2.
	self assert: table2 = table
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testKeys [
	| keys |
	keys := (1 to: 100) asOrderedCollection.
	keys do: [ :each |
		table at: each put: each asString ].
	self assert: table keys asArray sort = (1 to: 100) asArray
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testKeysAndValuesDo [
	| keys |
	keys := (1 to: 100) asOrderedCollection.
	keys do: [ :each |
		table at: each put: each ].
	table keysAndValuesDo: [ :key :value |
		self assert: key = value.
		self assert: (keys includes: key).
		keys remove: key ifAbsent: [ self fail ] ].
	self assert: keys isEmpty
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testKeysDo [
	| keys |
	keys := (1 to: 100) asOrderedCollection.
	keys do: [ :each |
		table at: each put: each ].
	table keysDo: [ :each |
		self assert: (keys includes: each).
		keys remove: each ifAbsent: [ self fail ] ].
	self assert: keys isEmpty
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testRemoveInteger [
	0 to: testsize do: [ :each |
		self assert: table size = each.
		table at: each put: each asString ].
	
	0 to: testsize by: 2 do: [ :each |
		self assert: (table includesKey: each).
		table removeKey: each.
		self deny: (table includesKey: each) ].
	
	1 to: testsize by: 2 do: [ :each |
		self assert: (table at: each) = each asString ].
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testRemoveString [
	| keys |
	keys := (0 to: testsize) collect: [ :each | each asString ].
	keys do: [ :each |
		self assert: table size = each asNumber.
		table at: each put: each asNumber ].
	
	0 to: testsize by: 2 do: [ :each |
		self assert: (table includesKey: (keys at: each + 1)).
		table removeKey: each asString.
		self deny: (table includesKey: each asString) ].
	
	1 to: testsize by: 2 do: [ :each |
		self assert: (table at: each asString) = each ].
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testSize [
	| keys |
	keys := (1 to: testsize) collect: [ :each | each asString ].
	self assert: table size = 0.
	
	keys do: [ :each |		
		table at: each put: each asNumber.
		self assert: table size = each asNumber. ].
	
	1 to: testsize do: [ :each |
		self assert: table size = testsize.
		self assert: (table at: each asString ) = each ].
	
	testsize to: 1 by: -1 do: [ :each |
		self assert: table size = each. 
		table removeKey: each asString ].
	
	self assert: table size = 0.
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testValues [
	| keys |
	keys := (1 to: 100) asOrderedCollection collect: [ :each | each asString ].
	keys do: [ :each |
		table at: each put: each ].
	self assert: ((table values collect: [ :each | each asNumber ]) asArray sort = (1 to: 100) asArray)
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testValuesDo [
	| keys |
	keys := (1 to: 100) asOrderedCollection.
	keys do: [ :each |
		table at: each put: each ].
	table valuesDo: [ :each |
		self assert: (keys includes: each).
		keys remove: each ifAbsent: [ self fail ] ].
	self assert: keys isEmpty
]

{ #category : #testing }
CTWeakKeyHashTableTest >> testWeakInstance [
	| createBlock string |
	createBlock := [(String new: 3)
		at: 1 put: $n;
		at: 2 put: $e;
		at: 3 put: $w;
		yourself ].
	string := createBlock value.
	
	table at: string put: true.
	self assert: (table at: string).
	self assert: (table at: createBlock value).
	self assert: table size = 1.
	string := nil.
	Smalltalk garbageCollect.
	
	string := createBlock value.
	self deny: (table includesKey: string).
	self assert: table isEmpty.
]
