Class {
	#name : #CTPrimeObject,
	#superclass : #Object,
	#category : #'Containers-HashTable-Tests-ObjectTester'
}

{ #category : #comparing }
CTPrimeObject >> hash [
	^self identityHash * 100799
]
