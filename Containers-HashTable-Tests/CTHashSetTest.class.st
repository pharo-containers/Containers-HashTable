Class {
	#name : #CTHashSetTest,
	#superclass : #TestCase,
	#traits : 'TCloneTest + TAddForUniquenessTest',
	#classTraits : 'TCloneTest classTrait + TAddForUniquenessTest classTrait',
	#instVars : [
		'set',
		'empty',
		'full',
		'collectionWith3Elements'
	],
	#category : #'Containers-HashTable-Tests-SUnit'
}

{ #category : #'as yet unclassified' }
CTHashSetTest class >> testSet [
	"self testSet"
	| set1 set2 |
	set1 := Set new
		add: 1;
		yourself.
	set2 := set1 copy.
	set2 add: 2.
	^set1 includes: 2
]

{ #category : #running }
CTHashSetTest >> classToBeTested [
	^ CTHashSet
]

{ #category : #'helper uniqueness' }
CTHashSetTest >> collectionWithElement [
	^ full
]

{ #category : #'helper uniqueness' }
CTHashSetTest >> collectionWithoutElement [
	" return a collection that does not include 'element' "
	^ collectionWith3Elements  
]

{ #category : #'helper uniqueness' }
CTHashSetTest >> element [
	^ 4
]

{ #category : #'helper clone' }
CTHashSetTest >> empty [
	
	^ empty
]

{ #category : #'helper clone' }
CTHashSetTest >> nonEmpty [
	
	^ full
]

{ #category : #running }
CTHashSetTest >> setUp [
	super setUp.
	set := self classToBeTested new.
	empty := self classToBeTested new.
	full := self classToBeTested  with: 1 with: 2 with: 3 with: 4.
	
	collectionWith3Elements := self classToBeTested new.
	collectionWith3Elements add: 1; add: -2; add: 3. 
]

{ #category : #testing }
CTHashSetTest >> testAdd [
	| set2 |
	0 to: 10 do: [ :each |
		set add: each ].
	set2 := set species new.
	11 to: 20 do: [ :each |
		set2 add: each ].
	set2 addAll: set.
	0 to: 20 do: [ :each |
		self assert: (set2 includes: each) ].
]

{ #category : #testing }
CTHashSetTest >> testAddNil [
	self should: [ set add: nil ] raise: Error
]

{ #category : #testing }
CTHashSetTest >> testCopy [
	| newSet |
	0 to: 10 do: [ :each |
		set add: each ].
	newSet := set copy.
	newSet add: 11.
	self assert: (newSet includes: 11).
	self deny: (set includes: 11).
	self assert: (newSet = (set copyWith: 11))
]

{ #category : #testing }
CTHashSetTest >> testDo [
	0 to: 10 do: [ :each |
		set add: each ].
	set do: [ :each |
		self assert: ((0 to: 10) includes: each)].
]

{ #category : #testing }
CTHashSetTest >> testEqualsSet [
	| set2 |
	set2 := Set new.
	0 to: 10 do: [ :each |
		set2 add: each.
		set add: each ].	
		
	self assert: set = set2
]

{ #category : #testing }
CTHashSetTest >> testEqualsSetTransitive [
	| set2 |
	set2 := set species new.
	0 to: 10 do: [ :each |
		set2 add: each.
		set add: each ].	
	
	self assert: set = set2.
	self assert: set2 = set
]

{ #category : #testing }
CTHashSetTest >> testRemove [
	0 to: 10 do: [ :each |
		set add: each ].
	0 to: 10 do: [ :each |
		set remove: each ].
	0 to: 10 do: [ :each |
		self deny: (set includes: each) ]
]

{ #category : #testing }
CTHashSetTest >> testSameHash [

	| string1 string2 |
	string1 := String newFrom: 'testme!'.
	string2 := String newFrom: 'testme!'.
	
	self assert: set isEmpty.
	self deny: (set includes: string1).
	self deny: (set includes: string2).
	
	set add: string1.
	self assert: set size = 1.
	self assert: (set includes: string1).
	self assert: (set includes: string2).
	
	set add: string1.
	self assert: set size = 1.
	self assert: (set includes: string1).
	self assert: (set includes: string2).
	
	set add: string2.
	self assert: set size = 1.
	self assert: (set includes: string1).
	self assert: (set includes: string2).
	
	set remove: string1.
	self assert: set isEmpty.
	self deny: (set includes: string1).
	self deny: (set includes: string2).
	
	self should: [ set remove: string2 ] raise: Error.
]

{ #category : #testing }
CTHashSetTest >> testSelect [
	| result |
	0 to: 10 do: [ :each |
		set add: each ].
	
	result := set select: [ :each | each even ].
	self assert: result size = 6.
	self assert: result = (0 to: 10 by: 2) asSet.
]

{ #category : #testing }
CTHashSetTest >> testSize [
	self assert: set size = 0.
	1 to: 10 do: [ :each |		
		set add: each.
		set size = each ].
	1 to: 10 do: [ :each |		
		set add: each.
		set size = 10 ].
	
	10 to: 1 by: -1 do: [ :each |		
		set size = each.
		set remove: each ].
	
	self assert: set size = 0.
]
