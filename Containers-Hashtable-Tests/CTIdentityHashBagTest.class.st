Class {
	#name : #CTIdentityHashBagTest,
	#superclass : #TestCase,
	#instVars : [
		'bag'
	],
	#category : #'Containers-HashTable-Tests-SUnit'
}

{ #category : #running }
CTIdentityHashBagTest >> setUp [
	super setUp.
	bag := CTIdentityHashBag new.
]

{ #category : #testing }
CTIdentityHashBagTest >> testAdd [
	| first second |
	first := String newFrom: 'key'.
	second := String newFrom: 'key'.
	
	bag add: first.
	bag add: first.
	
	bag add: second.
	bag add: second.
	bag add: second.	
	
	self assert: ((bag occurrencesOf: first) = 2).
	self assert: ((bag occurrencesOf: second) = 3)
]

{ #category : #testing }
CTIdentityHashBagTest >> testAddWithOccurrances [
	| first second |
	first := String newFrom: 'key'.
	second := String newFrom: 'key'.

	bag add: first withOccurrences: 2.
	bag add: second withOccurrences: 3.
	
	self assert: ((bag occurrencesOf: first) = 2)
]

{ #category : #testing }
CTIdentityHashBagTest >> testRemove [
	| first second |
	first := String newFrom: 'key'.
	second := String newFrom: 'key'.
	
	bag add: first withOccurrences: 2.
	bag add: second withOccurrences: 3.
	bag remove: first.
	
	self assert: ((bag occurrencesOf: first) = 1).
	
	bag remove: first.
	self assert: ((bag occurrencesOf: first) = 0).
	
	self should: [ bag remove: first ] raise: Error.
	self assert: ((bag occurrencesOf: first) = 0).
	self assert: ((bag occurrencesOf: second) = 3).
]
