Class {
	#name : #BaselineOfContainersHashTable,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersHashTable
}

{ #category : #baseline }
BaselineOfContainersHashTable >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec package: 'Containers-HashTable'.
			spec package: 'Containers-HashTable-Tests' with: [ spec requires: 'Containers-HashTable' ].
			
			spec group: 'default' with: #('Containers-HashTable' 'Containers-HashTable-Tests')
		]
]
