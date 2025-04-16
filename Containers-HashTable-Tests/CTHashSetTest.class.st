Class {
	#name : #CTHashSetTest,
	#superclass : #TestCase,
	#traits : 'TAddTest + TRemoveTest + TCloneTest + TAddForUniquenessTest',
	#classTraits : 'TAddTest classTrait + TRemoveTest classTrait + TCloneTest classTrait + TAddForUniquenessTest classTrait',
	#instVars : [
		'set',
		'empty',
		'full',
		'collectionWith3Elements'
	],
	#category : #'Containers-HashTable-Tests-SUnit'
}

{ #category : #accessing }
CTHashSetTest >> classToBeTested [
	"Returns the class under test."
	^ CTHashSet
]

{ #category : #setup }
CTHashSetTest >> setUp [
	"Set up the test fixtures."
	super setUp.
	set := self classToBeTested new.
	empty := self classToBeTested new.
	full := self classToBeTested with: 1 with: 2 with: 3 with: 4.
	collectionWith3Elements := self classToBeTested new
		add: 1;
		add: -2;
		add: 3;
		yourself
]

{ #category : #'tests - TAddTest' }
CTHashSetTest >> collection [
	"Returns the collection instance for TAddTest."
	^ set
]

{ #category : #'tests - TAddTest' }
CTHashSetTest >> elementToAdd [
	"Returns an element to add for TAddTest."
	^ 42
]

{ #category : #'tests - TRemoveTest' }
CTHashSetTest >> collectionWithElements [
	"Returns a collection with elements for TRemoveTest."
	^ full
]

{ #category : #'tests - TRemoveTest' }
CTHashSetTest >> elementInCollection [
	"Returns an element present in the collection for TRemoveTest."
	^ 2
]

{ #category : #'tests - TRemoveTest' }
CTHashSetTest >> elementNotInCollection [
	"Returns an element not present in the collection for TRemoveTest."
	^ 99
]

{ #category : #'tests - TCloneTest' }
CTHashSetTest >> empty [
	"Returns an empty collection for TCloneTest."
	^ empty
]

{ #category : #'tests - TCloneTest' }
CTHashSetTest >> nonEmpty [
	"Returns a non-empty collection for TCloneTest."
	^ full
]

{ #category : #'tests - TAddForUniquenessTest' }
CTHashSetTest >> collectionWithElement [
	"Returns a collection containing the element for TAddForUniquenessTest."
	^ full
]

{ #category : #'tests - TAddForUniquenessTest' }
CTHashSetTest >> collectionWithoutElement [
	"Returns a collection not containing the element for TAddForUniquenessTest."
	^ collectionWith3Elements
]

{ #category : #'tests - TAddForUniquenessTest' }
CTHashSetTest >> element [
	"Returns the element to test uniqueness for TAddForUniquenessTest."
	^ 4
]

{ #category : #testing }
CTHashSetTest >> testAddNil [
	"Test that adding nil raises an error, specific to CTHashSet."
	self should: [ set add: nil ] raise: Error
]

{ #category : #testing }
CTHashSetTest >> testSameHash [
	"Test behavior with objects that have the same hash but are equal."
	| string1 string2 |
	string1 := String newFrom: 'testme!'.
	string2 := String newFrom: 'testme!'.
	
	self assert: set isEmpty description: 'Set should start empty'.
	self deny: (set includes: string1) description: 'Set should not include string1 initially'.
	self deny: (set includes: string2) description: 'Set should not include string2 initially'.
	
	set add: string1.
	self assert: set size = 1 description: 'Size should be 1 after adding string1'.
	self assert: (set includes: string1) description: 'Set should include string1'.
	self assert: (set includes: string2) description: 'Set should include string2 due to equality'.
	
	set add: string1.
	self assert: set size = 1 description: 'Size should remain 1 when adding string1 again'.
	self assert: (set includes: string1) description: 'Set should still include string1'.
	self assert: (set includes: string2) description: 'Set should still include string2'.
	
	set add: string2.
	self assert: set size = 1 description: 'Size should remain 1 when adding string2'.
	self assert: (set includes: string1) description: 'Set should still include string1'.
	self assert: (set includes: string2) description: 'Set should still include string2'.
	
	set remove: string1.
	self assert: set isEmpty description: 'Set should be empty after removing string1'.
	self deny: (set includes: string1) description: 'Set should not include string1 after removal'.
	self deny: (set includes: string2) description: 'Set should not include string2 after removal'.
	
	self should: [ set remove: string2 ] raise: Error description: 'Removing string2 from empty set should raise an error'
]

{ #category : #testing }
CTHashSetTest >> testEqualsSet [
	"Test equality with a standard Set."
	| set2 |
	set2 := Set new.
	0 to: 10 do: [ :each |
		set2 add: each.
		set add: each ].	
	self assert: set = set2 description: 'CTHashSet should equal a standard Set with same elements'
]

{ #category : #testing }
CTHashSetTest >> testEqualsSetTransitive [
	"Test transitive equality between two CTHashSet instances."
	| set2 |
	set2 := self classToBeTested new.
	0 to: 10 do: [ :each |
		set2 add: each.
		set add: each ].	
	self assert: set = set2 description: 'set should equal set2'.
	self assert: set2 = set description: 'set2 should equal set (transitivity)'
]

{ #category : #testing }
CTHashSetTest >> testSelect [
	"Test the select: method for filtering elements."
	| result |
	0 to: 10 do: [ :each |
		set add: each ].
	result := set select: [ :each | each even ].
	self assert: result size = 6 description: 'Result should contain 6 even numbers'.
	self assert: result = (0 to: 10 by: 2) asSet description: 'Result should match even numbers from 0 to 10'
]