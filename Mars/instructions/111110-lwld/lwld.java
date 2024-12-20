import mars.Globals;
import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;
import mars.mips.instructions.SimulationCode;


public class lwld extends BranchOperation implements AdditionalInstruction {

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {
        
        int[] operands = statement.getOperands();
        try
        {
            int memword = Globals.memory.getWord(RegisterFile.getValue(operands[2]) + operands[1]);
            int address_cal = ((memword > 12288)&(((memword<<30)>>30)==0))? 31 : operands[0];
            RegisterFile.updateRegister(address_cal,memword);
        } 
        catch (AddressErrorException e)
        {
            throw new ProcessingException(statement, e);
        }

    }

    @Override
    public String getExample() {
        return "lwld $t1,-100($t2)";
    }

    @Override
    public String getDescription() {
        return "lwld";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.I_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "111110 ttttt fffff ssssssssssssssss";
    }
}
