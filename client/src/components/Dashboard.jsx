import CurrentTotals from "./CurrentTotals"
import { Stack, Box, Flex, Center } from "@chakra-ui/react"
import RV from "./RV"
import RV1 from "./RV1.jpeg"
import RV2 from "./RV2.jpeg"
import RV3 from "./RV3.jpeg"
import RenterForm from "./RenterForm"
import { useContext, useState } from "react"
import { BlockchainContext } from "../context/BlockchainContext"
import ClipLoader from 'react-spinners/ClipLoader';


const Dashboard = () => {
	const { renterExists, currentAccount } = useContext(BlockchainContext)
	let [loading, setLoading] = useState(true);
	return (
	<Stack 
		as={Box}
		textAlign={'center'}
		spacing={{ base: 8, md: 14 }}
		py={{ base: 20, md: 36 }}>

	{ renterExists == null  && currentAccount ? <Center><ClipLoader loading={loading} size={75} /> </Center> : renterExists ? <CurrentTotals /> : <RenterForm /> }

		
	<Flex justifyContent={'center'} alignItems={'center'}>
		<RV RV={RV1} />
		<RV RV={RV2}/>
		<RV RV={RV3} />
	</Flex>
	</Stack>
		)
}

export default Dashboard