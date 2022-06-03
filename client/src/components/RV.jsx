import { Button, Image, Text, Stack, Box, Flex } from "@chakra-ui/react"
import { useContext } from 'react'
import { BlockchainContext } from '../context/BlockchainContext'

const RV = ({ RV }) => {
	const { checkOut, checkIn } = useContext(BlockchainContext)
	return (
		<Box boxSize='lg' mx={2}>
			<Image src ={RV} mb={10} />
			<Text> Renting an RV offers the fun and flexibility of a road trip and also gives you a home on wheels wherever you go.
			</Text>
			<Stack spacing={0} direction={'row'} align={'center'} justify={'center'} mt={5}> 
			<Button
			onClick={checkOut}	
			m={2}
			fontSize={'small'}
			fontWeight={'600'}
			color={'white'}
		      bg={'teal.500'}
              _hover={{
                bg: 'teal.300',
              }}>
              Check Out
            </Button>

            <Button
            onClick={checkIn}
              m={2}
			fontSize={'small'}
			fontWeight={'600'}
			color={'white'}
		      bg={'teal.500'}
              _hover={{
                bg: 'teal.300',
              }}>
              Check In
            </Button>
			</Stack>
		</Box>
		)
	}


export default RV