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


public class lwtbi extends BranchOperation implements AdditionalInstruction {

    private int maxof(int value1, int value2) {
        int bitsV2 = (value2>>27) & 0b11111;
        if (value1 > bitsV2) return value1;
        else return bitsV2;
    }
    

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {

        int[] operands = statement.getOperands();
        try
        {
        RegisterFile.updateRegister(
            maxof(operands[0],Globals.memory.getWord(RegisterFile.getValue(operands[2]) + operands[1])),
            Globals.memory.getWord(RegisterFile.getValue(operands[2]) + operands[1]));
        } 
            catch (AddressErrorException e)
        {
            throw new ProcessingException(statement, e);
        }

    }

    @Override
    public String getExample() {
        return "lwtbi $t1,-100($t2)";
    }

    @Override
    public String getDescription() {
        return "lwtbi";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.I_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "111001 fffff sssss tttttttttttttttt";
    }
}
